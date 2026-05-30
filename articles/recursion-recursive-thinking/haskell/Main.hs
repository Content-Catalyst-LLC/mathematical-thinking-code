{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Recursion and Recursive Thinking

module Main where

import Data.List (intercalate)
import qualified Data.Map.Strict as M

data Tree a
  = Leaf a
  | Node a [Tree a]
  deriving (Eq, Show)

data Expr
  = Number Integer
  | Add Expr Expr
  | Multiply Expr Expr
  deriving (Eq, Show)

data RecursiveDefinition = RecursiveDefinition
  { definitionName :: String
  , baseCase :: String
  , recursiveRule :: String
  , terminationMeasure :: String
  } deriving (Eq, Show)

factorial :: Integer -> Integer
factorial n
  | n < 0 = error "factorial requires nonnegative input"
  | n == 0 = 1
  | otherwise = n * factorial (n - 1)

fibonacci :: Integer -> Integer
fibonacci n
  | n < 0 = error "fibonacci requires nonnegative input"
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fibonacci (n - 1) + fibonacci (n - 2)

fibonacciMemo :: Integer -> Integer
fibonacciMemo n = fst (fib n M.empty)
  where
    fib k memo
      | k < 0 = error "fibonacci requires nonnegative input"
      | k == 0 = (0, memo)
      | k == 1 = (1, memo)
      | otherwise =
          case M.lookup k memo of
            Just value -> (value, memo)
            Nothing ->
              let (a, memoA) = fib (k - 1) memo
                  (b, memoB) = fib (k - 2) memoA
                  value = a + b
               in (value, M.insert k value memoB)

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

evalExpr :: Expr -> Integer
evalExpr expr =
  case expr of
    Number n -> n
    Add left right -> evalExpr left + evalExpr right
    Multiply left right -> evalExpr left * evalExpr right

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

definitionRows :: [String]
definitionRows =
  let definitions =
        [ RecursiveDefinition "factorial" "0! = 1" "n! = n*(n-1)!" "n decreases by 1"
        , RecursiveDefinition "tree size" "leaf" "size(node)=1+sum(size(child))" "subtree depth decreases"
        , RecursiveDefinition "expression evaluation" "number" "evaluate subexpressions and combine" "expression depth decreases"
        ]
   in "name,base_case,recursive_rule,termination_measure,interpretation"
      : [ intercalate ","
            [ quote (definitionName d)
            , quote (baseCase d)
            , quote (recursiveRule d)
            , quote (terminationMeasure d)
            , quote "recursive definition requires base case and decreasing measure"
            ]
        | d <- definitions
        ]

recurrenceRows :: [String]
recurrenceRows =
  "n,factorial,fibonacci_naive,fibonacci_memo"
  : [ intercalate ","
        [ show n
        , show (factorial n)
        , show (fibonacci n)
        , show (fibonacciMemo n)
        ]
    | n <- [0..12]
    ]

treeRows :: [String]
treeRows =
  let proofTree = Node "theorem" [Node "lemma" [Leaf "definition", Leaf "case"], Leaf "corollary"]
      expression = Multiply (Add (Number 2) (Number 3)) (Number 5)
   in
      [ "structure_id,size_or_value,depth,interpretation"
      , intercalate "," ["proof_tree", show (treeSize proofTree), show (treeDepth proofTree), quote "tree metrics computed by structural recursion"]
      , intercalate "," ["expression_tree", show (evalExpr expression), "3", quote "expression evaluated by recursively evaluating subexpressions"]
      ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell recursion scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_recursive_definition_audit.csv" definitionRows
  writeLines "../outputs/tables/haskell_recurrence_audit.csv" recurrenceRows
  writeLines "../outputs/tables/haskell_tree_expression_audit.csv" treeRows
  putStrLn "Done."
