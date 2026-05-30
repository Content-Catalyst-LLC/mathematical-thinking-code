{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking for Computer Science

module Main where

import Data.List (intercalate)
import qualified Data.Set as S

data Tree a
  = Leaf a
  | Node a [Tree a]
  deriving (Eq, Show)

data AlgorithmClass
  = Constant
  | Logarithmic
  | Linear
  | NLogN
  | Quadratic
  | Exponential
  deriving (Eq, Show)

data AlgorithmSpec = AlgorithmSpec
  { algorithmName :: String
  , inputDomain :: String
  , outputSpec :: String
  , invariantNote :: String
  , complexityClass :: AlgorithmClass
  } deriving (Eq, Show)

data Result a e
  = Success a
  | Failure e
  deriving (Eq, Show)

data DFAState = Even | Odd
  deriving (Eq, Show)

treeSize :: Tree a -> Int
treeSize tree =
  case tree of
    Leaf _ -> 1
    Node _ children -> 1 + sum (map treeSize children)

treeDepth :: Tree a -> Int
treeDepth tree =
  case tree of
    Leaf _ -> 1
    Node _ [] -> 1
    Node _ children -> 1 + maximum (map treeDepth children)

transitionEvenOnes :: DFAState -> Char -> Result DFAState String
transitionEvenOnes state symbol =
  case (state, symbol) of
    (Even, '0') -> Success Even
    (Even, '1') -> Success Odd
    (Odd, '0') -> Success Odd
    (Odd, '1') -> Success Even
    (_, other) -> Failure ("invalid symbol: " ++ [other])

runDFA :: String -> Result DFAState String
runDFA input = go Even input
  where
    go state [] = Success state
    go state (x:xs) =
      case transitionEvenOnes state x of
        Success next -> go next xs
        Failure err -> Failure err

acceptsEvenOnes :: String -> Bool
acceptsEvenOnes input =
  case runDFA input of
    Success Even -> True
    _ -> False

type Graph = [(String, String)]

neighbors :: String -> Graph -> [String]
neighbors node edges =
  [b | (a,b) <- edges, a == node] ++ [a | (a,b) <- edges, b == node]

reachable :: Graph -> String -> [String]
reachable graph start = S.toList (go S.empty [start])
  where
    go visited [] = visited
    go visited (x:xs)
      | x `S.member` visited = go visited xs
      | otherwise = go (S.insert x visited) (xs ++ neighbors x graph)

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

algorithmRows :: [String]
algorithmRows =
  let specs =
        [ AlgorithmSpec "binary search" "sorted sequence" "found or missing" "target remains in active interval" Logarithmic
        , AlgorithmSpec "merge sort" "finite comparable list" "sorted permutation" "merge preserves sortedness and elements" NLogN
        , AlgorithmSpec "subset search" "finite set" "valid subset if one exists" "search enumerates possibility space" Exponential
        ]
   in "algorithm,input_domain,output_spec,invariant,complexity,interpretation"
      : [ intercalate ","
            [ quote (algorithmName spec)
            , quote (inputDomain spec)
            , quote (outputSpec spec)
            , quote (invariantNote spec)
            , show (complexityClass spec)
            , quote "algorithm specification connects representation, rule, proof, and cost"
            ]
        | spec <- specs
        ]

dfaRows :: [String]
dfaRows =
  "input,accepted,final_state,interpretation"
  : [ case runDFA input of
        Success state -> intercalate "," [quote (if null input then "epsilon" else input), show (acceptsEvenOnes input), show state, quote "finite-state machine tracks parity"]
        Failure err -> intercalate "," [quote input, "False", quote err, quote "invalid input outside alphabet"]
    | input <- ["", "0", "1", "11", "101", "1011", "1111"]
    ]

treeRows :: [String]
treeRows =
  let syntaxTree = Node "expression" [Leaf "x", Node "operator" [Leaf "+", Leaf "y"]]
      graph = [("A","B"), ("A","C"), ("B","D")]
   in
      [ "structure,value,interpretation"
      , intercalate "," ["tree_size", show (treeSize syntaxTree), quote "structural recursion over syntax tree"]
      , intercalate "," ["tree_depth", show (treeDepth syntaxTree), quote "tree depth measures nested structure"]
      , intercalate "," ["reachable_from_A", quote (unwords (reachable graph "A")), quote "graph traversal formalizes reachability"]
      ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell mathematical thinking for computer science scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_algorithm_spec_audit.csv" algorithmRows
  writeLines "../outputs/tables/haskell_dfa_audit.csv" dfaRows
  writeLines "../outputs/tables/haskell_structure_audit.csv" treeRows
  putStrLn "Done."
