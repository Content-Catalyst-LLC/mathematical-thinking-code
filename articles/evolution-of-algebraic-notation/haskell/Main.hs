{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- The Evolution of Algebraic Notation

module Main where

import Data.List (intercalate)

data Expr
  = Var String
  | Const Integer
  | Add Expr Expr
  | Mul Expr Expr
  | Pow Expr Integer
  deriving (Eq, Show)

data NotationStyle
  = Procedural
  | Rhetorical
  | Syncopated
  | Symbolic
  | Structural
  | Logical
  | Computational
  deriving (Eq, Show)

data SymbolRecord = SymbolRecord
  { symbolText :: String
  , meaningContext :: String
  , mathematicalRole :: String
  , ambiguityNote :: String
  } deriving (Eq, Show)

pretty :: Expr -> String
pretty expr =
  case expr of
    Var name -> name
    Const n -> show n
    Add a b -> "(" ++ pretty a ++ " + " ++ pretty b ++ ")"
    Mul a b -> "(" ++ pretty a ++ " * " ++ pretty b ++ ")"
    Pow base n -> pretty base ++ "^" ++ show n

nodeCount :: Expr -> Int
nodeCount expr =
  case expr of
    Var _ -> 1
    Const _ -> 1
    Add a b -> 1 + nodeCount a + nodeCount b
    Mul a b -> 1 + nodeCount a + nodeCount b
    Pow base _ -> 1 + nodeCount base + 1

depth :: Expr -> Int
depth expr =
  case expr of
    Var _ -> 1
    Const _ -> 1
    Add a b -> 1 + max (depth a) (depth b)
    Mul a b -> 1 + max (depth a) (depth b)
    Pow base _ -> 1 + depth base

eval :: Integer -> Expr -> Integer
eval x expr =
  case expr of
    Var "x" -> x
    Var _ -> error "only x is supported in this simple evaluator"
    Const n -> n
    Add a b -> eval x a + eval x b
    Mul a b -> eval x a * eval x b
    Pow base n -> eval x base ^ n

expanded :: Expr
expanded = Add (Add (Pow (Var "x") 2) (Mul (Const 2) (Var "x"))) (Const 1)

factored :: Expr
factored = Pow (Add (Var "x") (Const 1)) 2

symbols :: [SymbolRecord]
symbols =
  [ SymbolRecord "x" "unknown or variable" "quantity, input, placeholder, coordinate, or element"
      "context determines meaning"
  , SymbolRecord "=" "equality relation" "equation, identity, definition, or sameness"
      "not the same as programming assignment"
  , SymbolRecord "f(x)" "function application" "output of function f at input x"
      "can be mistaken for multiplication"
  , SymbolRecord "(G,*)" "algebraic structure" "set with an operation satisfying laws"
      "operation is abstract and may not be ordinary multiplication"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

expressionRows :: [String]
expressionRows =
  [ "expression_id,pretty_expression,node_count,depth,notation_style,interpretation"
  , intercalate "," ["expanded", quote (pretty expanded), show (nodeCount expanded), show (depth expanded), show Symbolic, quote "symbolic expression as typed tree"]
  , intercalate "," ["factored", quote (pretty factored), show (nodeCount factored), show (depth factored), show Symbolic, quote "factored expression as typed tree"]
  ]

identityRows :: [String]
identityRows =
  "x,expanded_value,factored_value,holds,interpretation"
  : [ intercalate ","
        [ show x
        , show (eval x expanded)
        , show (eval x factored)
        , show (eval x expanded == eval x factored)
        , quote "finite checks illustrate but do not replace symbolic proof"
        ]
    | x <- [-10..10]
    ]

symbolRows :: [String]
symbolRows =
  "symbol,meaning_context,mathematical_role,ambiguity_note,interpretation"
  : [ intercalate ","
        [ quote (symbolText item)
        , quote (meaningContext item)
        , quote (mathematicalRole item)
        , quote (ambiguityNote item)
        , quote "notation requires context and pedagogy"
        ]
    | item <- symbols
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell algebraic-notation scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_expression_tree_audit.csv" expressionRows
  writeLines "../outputs/tables/haskell_polynomial_identity_audit.csv" identityRows
  writeLines "../outputs/tables/haskell_symbol_context_audit.csv" symbolRows
  putStrLn "Done."
