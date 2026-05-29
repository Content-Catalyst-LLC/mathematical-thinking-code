{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Discrete Mathematics and the Logic of Structure

module Main where

import Data.List (intercalate, nub)

data Vertex = A | B | C | D | E
  deriving (Eq, Ord, Show, Enum, Bounded)

data Edge = Edge Vertex Vertex
  deriving (Eq, Show)

data Proposition
  = Atom String Bool
  | Not Proposition
  | And Proposition Proposition
  | Or Proposition Proposition
  | Implies Proposition Proposition
  deriving (Eq, Show)

data Tree a
  = Leaf a
  | Node a [Tree a]
  deriving (Eq, Show)

data ProofStatus
  = FiniteEvidence
  | Proved
  | Refuted
  | NeedsReview
  deriving (Eq, Show)

vertices :: [Vertex]
vertices = [minBound .. maxBound]

edges :: [Edge]
edges =
  [ Edge A B
  , Edge A C
  , Edge B D
  ]

neighbors :: Vertex -> [Edge] -> [Vertex]
neighbors v es =
  nub $
    [ y | Edge x y <- es, x == v ] ++
    [ x | Edge x y <- es, y == v ]

degree :: Vertex -> [Edge] -> Int
degree v es = length (neighbors v es)

treeSize :: Tree a -> Int
treeSize tree =
  case tree of
    Leaf _ -> 1
    Node _ children -> 1 + sum (map treeSize children)

eval :: Proposition -> Bool
eval proposition =
  case proposition of
    Atom _ value -> value
    Not p -> not (eval p)
    And p q -> eval p && eval q
    Or p q -> eval p || eval q
    Implies p q -> not (eval p) || eval q

fibonacci :: Int -> Integer
fibonacci n
  | n < 0 = error "fibonacci is defined here only for nonnegative integers"
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = go 0 1 2
  where
    go previous current index
      | index > n = current
      | otherwise = go current (previous + current) (index + 1)

binomial :: Integer -> Integer -> Integer
binomial n k
  | k < 0 || k > n = 0
  | otherwise = product [n-k+1..n] `div` product [1..k]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

graphRows :: [String]
graphRows =
  "vertex,degree,neighbors,interpretation"
  : [ intercalate ","
        [ show v
        , show (degree v edges)
        , quote (unwords (map show (neighbors v edges)))
        , quote "degree and neighbor structure are graph properties independent of layout"
        ]
    | v <- vertices
    ]

booleanRows :: [String]
booleanRows =
  "P,Q,not_P,P_and_Q,P_or_Q,P_implies_Q"
  : [ intercalate ","
        [ show p
        , show q
        , show (eval (Not (Atom "P" p)))
        , show (eval (And (Atom "P" p) (Atom "Q" q)))
        , show (eval (Or (Atom "P" p) (Atom "Q" q)))
        , show (eval (Implies (Atom "P" p) (Atom "Q" q)))
        ]
    | p <- [False, True], q <- [False, True]
    ]

recurrenceRows :: [String]
recurrenceRows =
  "n,fibonacci,residue_mod_7,binomial_10_choose_n"
  : [ intercalate ","
        [ show n
        , show (fibonacci n)
        , show (n `mod` 7)
        , show (binomial 10 (toInteger n))
        ]
    | n <- [0..10]
    ]

treeRows :: [String]
treeRows =
  let proofTree = Node "theorem" [Node "lemma" [Leaf "definition"], Leaf "case analysis"]
   in
      [ "tree_id,size,interpretation"
      , intercalate "," ["proof_tree", show (treeSize proofTree), quote "proof trees represent dependency structure"]
      ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell discrete mathematics scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_graph_audit.csv" graphRows
  writeLines "../outputs/tables/haskell_boolean_audit.csv" booleanRows
  writeLines "../outputs/tables/haskell_recurrence_audit.csv" recurrenceRows
  writeLines "../outputs/tables/haskell_tree_audit.csv" treeRows
  putStrLn "Done."
