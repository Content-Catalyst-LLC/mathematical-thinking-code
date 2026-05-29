{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Symbols, Language, and Mathematical Representation
--
-- This file models mathematical symbols as algebraic data types:
-- expressions, propositions, graph representations, rendering, evaluation,
-- truth tables, and representation audits.

module Main where

import Data.List (intercalate, nub, sort)

data Expr
  = Var String
  | Const Double
  | Add Expr Expr
  | Mul Expr Expr
  | Pow Expr Int
  deriving (Eq, Show)

type Environment = [(String, Double)]

lookupVar :: String -> Environment -> Double
lookupVar name env =
  case lookup name env of
    Just value -> value
    Nothing -> error ("unbound variable: " ++ name)

eval :: Environment -> Expr -> Double
eval env expr =
  case expr of
    Var name -> lookupVar name env
    Const value -> value
    Add left right -> eval env left + eval env right
    Mul left right -> eval env left * eval env right
    Pow base exponent -> eval env base ^ exponent

render :: Expr -> String
render expr =
  case expr of
    Var name -> name
    Const value -> show value
    Add left right -> "(" ++ render left ++ " + " ++ render right ++ ")"
    Mul left right -> "(" ++ render left ++ " * " ++ render right ++ ")"
    Pow base exponent -> "(" ++ render base ++ "^" ++ show exponent ++ ")"

data Prop
  = Atom String
  | Not Prop
  | And Prop Prop
  | Or Prop Prop
  | Implies Prop Prop
  | Iff Prop Prop
  deriving (Eq, Show)

type Valuation = [(String, Bool)]

lookupAtom :: String -> Valuation -> Bool
lookupAtom name valuation =
  case lookup name valuation of
    Just value -> value
    Nothing -> False

evalProp :: Valuation -> Prop -> Bool
evalProp valuation proposition =
  case proposition of
    Atom name -> lookupAtom name valuation
    Not p -> not (evalProp valuation p)
    And p q -> evalProp valuation p && evalProp valuation q
    Or p q -> evalProp valuation p || evalProp valuation q
    Implies p q -> not (evalProp valuation p) || evalProp valuation q
    Iff p q -> evalProp valuation p == evalProp valuation q

boolText :: Bool -> String
boolText value = if value then "true" else "false"

truthTable :: [String]
truthTable =
  let header = "P,Q,P_implies_Q,contrapositive,equivalent"
      rows =
        [ intercalate ","
            [ boolText p
            , boolText q
            , boolText original
            , boolText contrapositive
            , boolText (original == contrapositive)
            ]
        | p <- [False, True]
        , q <- [False, True]
        , let valuation = [("P", p), ("Q", q)]
        , let original = evalProp valuation (Implies (Atom "P") (Atom "Q"))
        , let contrapositive = evalProp valuation (Implies (Not (Atom "Q")) (Not (Atom "P")))
        ]
   in header : rows

type Edge = (String, String)

vertices :: [Edge] -> [String]
vertices edges = sort . nub $ concat [[a,b] | (a,b) <- edges]

degree :: String -> [Edge] -> Int
degree v edges = length [() | (a,b) <- edges, a == v || b == v]

degreeSequence :: [Edge] -> [Int]
degreeSequence edges = reverse . sort $ [degree v edges | v <- vertices edges]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

expressionAudit :: [String]
expressionAudit =
  let expr = Mul (Add (Var "x") (Const 2.0)) (Var "y")
      env = [("x", 3.0), ("y", 4.0)]
   in
      [ "expression_id,rendered_expression,evaluated_value,interpretation"
      , intercalate ","
          [ "expr_product"
          , quote (render expr)
          , show (eval env expr)
          , quote "algebraic data type preserves expression-tree structure"
          ]
      ]

graphAudit :: [String]
graphAudit =
  let graphs =
        [ ("cycle4", [("a","b"),("b","c"),("c","d"),("d","a")])
        , ("path4", [("a","b"),("b","c"),("c","d")])
        ]
   in "graph_id,vertex_count,edge_count,degree_sequence,interpretation"
      : [ intercalate ","
            [ name
            , show (length (vertices edges))
            , show (length edges)
            , quote (unwords (map show (degreeSequence edges)))
            , quote "graph representation preserves adjacency but omits drawing geometry"
            ]
        | (name, edges) <- graphs
        ]

writeLines :: FilePath -> [String] -> IO ()
writeLines path rows = writeFile path (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell symbolic representation scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"

  writeLines "../outputs/tables/haskell_expression_audit.csv" expressionAudit
  writeLines "../outputs/tables/haskell_truth_table.csv" truthTable
  writeLines "../outputs/tables/haskell_graph_audit.csv" graphAudit

  putStrLn "Done."
