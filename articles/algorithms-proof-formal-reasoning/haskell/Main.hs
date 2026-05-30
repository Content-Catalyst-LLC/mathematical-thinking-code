{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Algorithms, Proof, and Formal Reasoning

module Main where

import Data.List (intercalate, sort)

data Complexity
  = Constant
  | Logarithmic
  | Linear
  | NLogN
  | Quadratic
  | Exponential
  deriving (Eq, Show)

data ProofMethod
  = LoopInvariant
  | Induction
  | StructuralInduction
  | GreedyInvariant
  | CaseAnalysis
  | DataStructureInvariant
  deriving (Eq, Show)

data AlgorithmSpec = AlgorithmSpec
  { algorithmName :: String
  , precondition :: String
  , postcondition :: String
  , invariant :: String
  , terminationMeasure :: String
  , proofMethod :: ProofMethod
  , complexity :: Complexity
  } deriving (Eq, Show)

data Result a e
  = Success a
  | Failure e
  deriving (Eq, Show)

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:rest) = x <= y && isSorted (y:rest)

sameMultiset :: Ord a => [a] -> [a] -> Bool
sameMultiset left right = sort left == sort right

safeHead :: [a] -> Result a String
safeHead [] = Failure "empty list has no head"
safeHead (x:_) = Success x

binarySearchSpec :: AlgorithmSpec
binarySearchSpec =
  AlgorithmSpec
    { algorithmName = "binary search"
    , precondition = "input sequence is sorted"
    , postcondition = "returns target position or missing result"
    , invariant = "target, if present, remains in active interval"
    , terminationMeasure = "active interval length decreases"
    , proofMethod = LoopInvariant
    , complexity = Logarithmic
    }

insertionSortSpec :: AlgorithmSpec
insertionSortSpec =
  AlgorithmSpec
    { algorithmName = "insertion sort"
    , precondition = "finite comparable list"
    , postcondition = "sorted permutation of input"
    , invariant = "processed prefix is sorted"
    , terminationMeasure = "unprocessed suffix length decreases"
    , proofMethod = LoopInvariant
    , complexity = Quadratic
    }

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

specRows :: [String]
specRows =
  let specs = [binarySearchSpec, insertionSortSpec]
   in "algorithm,precondition,postcondition,invariant,termination_measure,proof_method,complexity,interpretation"
      : [ intercalate ","
            [ quote (algorithmName spec)
            , quote (precondition spec)
            , quote (postcondition spec)
            , quote (invariant spec)
            , quote (terminationMeasure spec)
            , show (proofMethod spec)
            , show (complexity spec)
            , quote "typed metadata makes proof obligations explicit"
            ]
        | spec <- specs
        ]

postconditionRows :: [String]
postconditionRows =
  let input = [5, 2, 8, 1, 3, 2]
      output = sort input
   in
      [ "input,output,is_sorted,same_multiset,interpretation"
      , intercalate ","
          [ quote (unwords (map show input))
          , quote (unwords (map show output))
          , show (isSorted output)
          , show (sameMultiset input output)
          , quote "sorting postcondition requires sortedness and multiset preservation"
          ]
      ]

resultRows :: [String]
resultRows =
  [ "case,result,interpretation"
  , intercalate "," ["safe_head_empty", quote (show (safeHead ([] :: [Int]))), quote "sum type represents explicit failure"]
  , intercalate "," ["safe_head_nonempty", quote (show (safeHead [10,20,30])), quote "sum type represents explicit success"]
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell algorithms/proof/formal reasoning scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_algorithm_spec_audit.csv" specRows
  writeLines "../outputs/tables/haskell_sort_postcondition_audit.csv" postconditionRows
  writeLines "../outputs/tables/haskell_result_type_audit.csv" resultRows
  putStrLn "Done."
