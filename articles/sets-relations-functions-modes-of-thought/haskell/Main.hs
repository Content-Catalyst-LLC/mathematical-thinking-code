{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Sets, Relations, and Functions as Modes of Thought

module Main where

import Data.List (intercalate, nub)

type Relation a b = [(a, b)]

data ProofStatus
  = Observed
  | VerifiedFinite
  | Proved
  | Refuted
  deriving (Eq, Show)

data TypedFunction a b = TypedFunction
  { functionName :: String
  , domain :: [a]
  , codomain :: [b]
  , mapping :: Relation a b
  , validationNote :: String
  } deriving (Eq, Show)

unique :: Eq a => [a] -> [a]
unique = nub

image :: Eq b => [a] -> (a -> b) -> [b]
image xs f = unique [f x | x <- xs]

isFunction :: Eq a => [a] -> Relation a b -> Bool
isFunction xs relation =
  all hasOneOutput xs
  where
    hasOneOutput x =
      length [y | (x', y) <- relation, x' == x] == 1

validateFunction :: (Eq a, Eq b) => TypedFunction a b -> (Bool, String)
validateFunction f
  | not (isFunction (domain f) (mapping f)) = (False, "not exactly one output for every domain element")
  | any (`notElem` domain f) [x | (x, _) <- mapping f] = (False, "mapping includes input outside domain")
  | any (`notElem` codomain f) [y | (_, y) <- mapping f] = (False, "mapping includes output outside codomain")
  | otherwise = (True, "valid total function on stated domain and codomain")

isReflexive :: Eq a => [a] -> Relation a a -> Bool
isReflexive xs relation =
  all (\x -> (x, x) `elem` relation) xs

isSymmetric :: Eq a => Relation a a -> Bool
isSymmetric relation =
  all (\(x, y) -> (y, x) `elem` relation) relation

isTransitive :: Eq a => Relation a a -> Bool
isTransitive relation =
  all (\(x, y, z) -> (x, z) `elem` relation)
      [ (x, y, z)
      | (x, y) <- relation
      , (y2, z) <- relation
      , y == y2
      ]

isAntisymmetric :: Eq a => Relation a a -> Bool
isAntisymmetric relation =
  all (\(x, y) -> x == y || (y, x) `notElem` relation) relation

modRelation :: Int -> [Int] -> Relation Int Int
modRelation modulus xs =
  [ (x, y) | x <- xs, y <- xs, x `mod` modulus == y `mod` modulus ]

dividesRelation :: [Int] -> Relation Int Int
dividesRelation xs =
  [ (x, y) | x <- xs, y <- xs, y `mod` x == 0 ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

relationRows :: [String]
relationRows =
  let d = [1,2,3,4]
      rel = modRelation 2 d
      divDomain = [1,2,3,4,6,12]
      divRel = dividesRelation divDomain
   in "relation_id,reflexive,symmetric,transitive,antisymmetric,equivalence_relation,partial_order"
      : [ intercalate ","
            [ "mod2"
            , show (isReflexive d rel)
            , show (isSymmetric rel)
            , show (isTransitive rel)
            , show (isAntisymmetric rel)
            , show (isReflexive d rel && isSymmetric rel && isTransitive rel)
            , show (isReflexive d rel && isAntisymmetric rel && isTransitive rel)
            ]
        , intercalate ","
            [ "divides"
            , show (isReflexive divDomain divRel)
            , show (isSymmetric divRel)
            , show (isTransitive divRel)
            , show (isAntisymmetric divRel)
            , show (isReflexive divDomain divRel && isSymmetric divRel && isTransitive divRel)
            , show (isReflexive divDomain divRel && isAntisymmetric divRel && isTransitive divRel)
            ]
        ]

functionRows :: [String]
functionRows =
  let good = TypedFunction "double" [1,2,3,4] [2,4,6,8] [(1,2),(2,4),(3,6),(4,8)] "finite typed mapping"
      bad = TypedFunction "missing_input" [2,4,6,8] [1,2,3,4] [(2,1),(4,2),(6,3)] "missing one domain input"
      rows = [good, bad]
   in "function_name,is_valid,validation_message,validation_note"
      : [ let (ok, msg) = validateFunction f
           in intercalate "," [functionName f, show ok, quote msg, quote (validationNote f)]
        | f <- rows
        ]

compositionRows :: [String]
compositionRows =
  "input,after_double,after_label,composition"
  : [ let y = 2 * x
          label = if y <= 2 then "low" else if y <= 6 then "medium" else "high"
       in intercalate "," [show x, show y, label, "label(double(x))"]
    | x <- [1,2,3,4 :: Int]
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell sets-relations-functions scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_relation_property_audit.csv" relationRows
  writeLines "../outputs/tables/haskell_function_validation.csv" functionRows
  writeLines "../outputs/tables/haskell_composition_audit.csv" compositionRows
  putStrLn "Done."
