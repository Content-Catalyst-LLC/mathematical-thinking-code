{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Combinatorics and the Mathematics of Possibility

module Main where

import Data.List (intercalate)

data ChoiceRule
  = OrderMatters
  | OrderDoesNotMatter
  deriving (Eq, Show)

data RepetitionRule
  = RepetitionAllowed
  | RepetitionNotAllowed
  deriving (Eq, Show)

data CountingProblem = CountingProblem
  { problemName :: String
  , numberOfObjects :: Integer
  , selectedObjects :: Maybe Integer
  , choiceRule :: ChoiceRule
  , repetitionRule :: RepetitionRule
  , constraintNote :: String
  } deriving (Eq, Show)

data CountMethod
  = Combination
  | Permutation
  | MultiplicationPrinciple
  | PowerSet
  | SimpleGraphCount
  | FibonacciTiling
  deriving (Eq, Show)

factorial :: Integer -> Integer
factorial n
  | n < 0 = error "factorial requires nonnegative input"
  | n == 0 = 1
  | otherwise = product [1..n]

permutation :: Integer -> Integer -> Integer
permutation n k = factorial n `div` factorial (n - k)

combination :: Integer -> Integer -> Integer
combination n k = factorial n `div` (factorial k * factorial (n - k))

simpleGraphCount :: Integer -> Integer
simpleGraphCount n = 2 ^ combination n 2

fibonacciTilings :: Integer -> Integer
fibonacciTilings n
  | n < 0 = error "tiling length must be nonnegative"
  | n == 0 = 1
  | n == 1 = 1
  | otherwise = go 1 1 2
  where
    go previous current index
      | index > n = current
      | otherwise = go current (previous + current) (index + 1)

countProblem :: CountingProblem -> Maybe (CountMethod, Integer)
countProblem problem =
  case (choiceRule problem, repetitionRule problem, selectedObjects problem) of
    (OrderMatters, RepetitionNotAllowed, Just k) ->
      Just (Permutation, permutation (numberOfObjects problem) k)
    (OrderDoesNotMatter, RepetitionNotAllowed, Just k) ->
      Just (Combination, combination (numberOfObjects problem) k)
    (OrderMatters, RepetitionAllowed, Just k) ->
      Just (MultiplicationPrinciple, numberOfObjects problem ^ k)
    (OrderDoesNotMatter, RepetitionNotAllowed, Nothing) ->
      Just (PowerSet, 2 ^ numberOfObjects problem)
    _ -> Nothing

pascalRow :: Integer -> [Integer]
pascalRow n = [combination n k | k <- [0..n]]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

problemRows :: [String]
problemRows =
  let problems =
        [ CountingProblem "committee" 10 (Just 3) OrderDoesNotMatter RepetitionNotAllowed "membership matters"
        , CountingProblem "ranked finalists" 10 (Just 3) OrderMatters RepetitionNotAllowed "rank order matters"
        , CountingProblem "password" 36 (Just 6) OrderMatters RepetitionAllowed "repetition allowed"
        , CountingProblem "feature subsets" 20 Nothing OrderDoesNotMatter RepetitionNotAllowed "any subset of features"
        ]
   in "problem_name,method,count,constraint_note,interpretation"
      : [ case countProblem p of
            Just (method, count) ->
              intercalate "," [quote (problemName p), show method, show count, quote (constraintNote p), quote "count is meaningful under stated assumptions"]
            Nothing ->
              intercalate "," [quote (problemName p), "Unsupported", "", quote (constraintNote p), quote "method requires explicit combinatorial assumptions"]
        | p <- problems
        ]

pascalRows :: [String]
pascalRows =
  "n,row_values,row_sum,expected_power_of_two"
  : [ intercalate ","
        [ show n
        , quote (unwords (map show (pascalRow n)))
        , show (sum (pascalRow n))
        , show (2 ^ n :: Integer)
        ]
    | n <- [0..12]
    ]

growthRows :: [String]
growthRows =
  "n,subsets,permutations,simple_labeled_graphs,fibonacci_tilings"
  : [ intercalate ","
        [ show n
        , show (2 ^ n :: Integer)
        , show (factorial n)
        , show (simpleGraphCount n)
        , show (fibonacciTilings n)
        ]
    | n <- [1..12]
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell combinatorics scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_counting_problem_audit.csv" problemRows
  writeLines "../outputs/tables/haskell_pascal_audit.csv" pascalRows
  writeLines "../outputs/tables/haskell_search_growth_audit.csv" growthRows
  putStrLn "Done."
