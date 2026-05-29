{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Geometry and the Visual Mind in Mathematics

module Main where

import Data.List (intercalate)

data Point = Point Double Double
  deriving (Eq, Show)

data Shape
  = Segment Point Point
  | Triangle Point Point Point
  | Circle Point Double
  deriving (Eq, Show)

data Transformation
  = Translate Double Double
  | Rotate90
  | ReflectX
  | Scale Double
  deriving (Eq, Show)

distance :: Point -> Point -> Double
distance (Point x1 y1) (Point x2 y2) =
  sqrt ((x2 - x1)^2 + (y2 - y1)^2)

triangleArea :: Point -> Point -> Point -> Double
triangleArea (Point x1 y1) (Point x2 y2) (Point x3 y3) =
  abs (x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)) / 2

orientation :: Point -> Point -> Point -> Double
orientation (Point x1 y1) (Point x2 y2) (Point x3 y3) =
  (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)

transform :: Transformation -> Point -> Point
transform t (Point x y) =
  case t of
    Translate dx dy -> Point (x + dx) (y + dy)
    Rotate90 -> Point (-y) x
    ReflectX -> Point x (-y)
    Scale s -> Point (s*x) (s*y)

squaredNorm :: Point -> Double
squaredNorm (Point x y) = x*x + y*y

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

pointRows :: [String]
pointRows =
  let points =
        [ ("A", Point 0 0)
        , ("B", Point 4 0)
        , ("C", Point 0 3)
        , ("F", Point 0.6 0.8)
        , ("G", Point 0.5 0.5)
        ]
   in "point_id,squared_norm,on_unit_circle,interpretation"
      : [ intercalate ","
            [ pid
            , show (squaredNorm p)
            , show (abs (squaredNorm p - 1.0) < 1.0e-10)
            , quote "coordinate residual checks geometric relation"
            ]
        | (pid, p) <- points
        ]

triangleRows :: [String]
triangleRows =
  let a = Point 0 0
      b = Point 4 0
      c = Point 0 3
   in
      [ "measurement_id,value,interpretation"
      , intercalate "," ["side_AB", show (distance a b), quote "distance from coordinate representation"]
      , intercalate "," ["side_BC", show (distance b c), quote "distance from coordinate representation"]
      , intercalate "," ["side_CA", show (distance c a), quote "distance from coordinate representation"]
      , intercalate "," ["area_ABC", show (triangleArea a b c), quote "area from determinant formula"]
      , intercalate "," ["orientation_ABC", show (orientation a b c), quote "signed orientation and twice signed area"]
      ]

transformRows :: [String]
transformRows =
  let p = Point 4 0
      transformations = [Rotate90, ReflectX, Scale 2]
   in "transformation,before_squared_norm,after_squared_norm,distance_preserved"
      : [ intercalate ","
            [ show t
            , show (squaredNorm p)
            , show (squaredNorm (transform t p))
            , show (abs (squaredNorm p - squaredNorm (transform t p)) < 1.0e-10)
            ]
        | t <- transformations
        ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell geometry and visual mind scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_point_membership.csv" pointRows
  writeLines "../outputs/tables/haskell_triangle_measurements.csv" triangleRows
  writeLines "../outputs/tables/haskell_transformation_audit.csv" transformRows
  putStrLn "Done."
