{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Graphs, Networks, and Discrete Structure

module Main where

import Data.List (intercalate, nub)
import qualified Data.Set as S

data Vertex = A | B | C | D | E
  deriving (Eq, Ord, Show, Enum, Bounded)

data Edge
  = Undirected Vertex Vertex
  | Directed Vertex Vertex
  deriving (Eq, Show)

data WeightedEdge = WeightedEdge Vertex Vertex Double
  deriving (Eq, Show)

type Graph = [Edge]

vertices :: [Vertex]
vertices = [minBound .. maxBound]

undirectedEdges :: Graph
undirectedEdges =
  [ Undirected A B
  , Undirected A C
  , Undirected B D
  ]

weightedEdges :: [WeightedEdge]
weightedEdges =
  [ WeightedEdge A D 7.0
  , WeightedEdge A B 2.0
  , WeightedEdge B D 3.0
  , WeightedEdge A C 5.0
  , WeightedEdge C D 1.0
  ]

neighbors :: Vertex -> Graph -> [Vertex]
neighbors v edges =
  nub $
    [ y | Undirected x y <- edges, x == v ] ++
    [ x | Undirected x y <- edges, y == v ] ++
    [ y | Directed x y <- edges, x == v ]

degree :: Vertex -> Graph -> Int
degree v graph = length (neighbors v graph)

isAdjacent :: Vertex -> Vertex -> Graph -> Bool
isAdjacent u v graph =
  Undirected u v `elem` graph ||
  Undirected v u `elem` graph ||
  Directed u v `elem` graph

reachable :: Graph -> Vertex -> [Vertex]
reachable graph start = S.toList (go S.empty [start])
  where
    go visited [] = visited
    go visited (x:xs)
      | x `S.member` visited = go visited xs
      | otherwise =
          let next = neighbors x graph
           in go (S.insert x visited) (xs ++ next)

handshakingDegreeSum :: Graph -> Int
handshakingDegreeSum graph = sum [degree v graph | v <- vertices]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

degreeRows :: [String]
degreeRows =
  "vertex,degree,neighbors,reachable_from_vertex,interpretation"
  : [ intercalate ","
        [ show v
        , show (degree v undirectedEdges)
        , quote (unwords (map show (neighbors v undirectedEdges)))
        , quote (unwords (map show (reachable undirectedEdges v)))
        , quote "degree is local; reachability describes component structure"
        ]
    | v <- vertices
    ]

weightedRows :: [String]
weightedRows =
  "source,target,weight,interpretation"
  : [ intercalate ","
        [ show source
        , show target
        , show weight
        , quote "edge weight requires documented semantic meaning"
        ]
    | WeightedEdge source target weight <- weightedEdges
    ]

handshakingRows :: [String]
handshakingRows =
  [ "degree_sum,twice_edge_count,agrees,interpretation"
  , intercalate ","
      [ show (handshakingDegreeSum undirectedEdges)
      , show (2 * length undirectedEdges)
      , show (handshakingDegreeSum undirectedEdges == 2 * length undirectedEdges)
      , quote "sum of degrees equals twice the number of undirected edges"
      ]
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell graph scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_degree_reachability_audit.csv" degreeRows
  writeLines "../outputs/tables/haskell_weighted_edge_audit.csv" weightedRows
  writeLines "../outputs/tables/haskell_handshaking_audit.csv" handshakingRows
  putStrLn "Done."
