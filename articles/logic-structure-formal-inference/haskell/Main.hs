{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for Logic and the Structure of Formal Inference
-- Article folder: logic-structure-formal-inference
--
-- This file uses algebraic data types and pure functions to model
-- propositions, truth-functional inference, proof dependencies,
-- sequence-pattern audits, and graph invariants.
--
-- It is intentionally dependency-light so it can run with a standard
-- GHC installation:
--
--   ghc -O2 Main.hs -o formal_math_demo
--   ./formal_math_demo

module Main where

import Data.List (intercalate, nub, sort)

articleSlug :: String
articleSlug = "logic-structure-formal-inference"

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

eval :: Valuation -> Prop -> Bool
eval valuation proposition =
  case proposition of
    Atom name -> lookupAtom name valuation
    Not p -> not (eval valuation p)
    And p q -> eval valuation p && eval valuation q
    Or p q -> eval valuation p || eval valuation q
    Implies p q -> not (eval valuation p) || eval valuation q
    Iff p q -> eval valuation p == eval valuation q

boolText :: Bool -> String
boolText value = if value then "true" else "false"

truthTable :: [String]
truthTable =
  let header = "P,Q,P_implies_Q,converse_Q_implies_P,contrapositive_notQ_implies_notP,contrapositive_equivalent"
      rows =
        [ intercalate ","
            [ boolText p
            , boolText q
            , boolText original
            , boolText converse
            , boolText contrapositive
            , boolText (original == contrapositive)
            ]
        | p <- [False, True]
        , q <- [False, True]
        , let valuation = [("P", p), ("Q", q)]
        , let original = eval valuation (Implies (Atom "P") (Atom "Q"))
        , let converse = eval valuation (Implies (Atom "Q") (Atom "P"))
        , let contrapositive = eval valuation (Implies (Not (Atom "Q")) (Not (Atom "P")))
        ]
   in header : rows

data ProofStep = ProofStep
  { stepId :: String
  , statement :: String
  , justification :: String
  } deriving (Eq, Show)

data Dependency = Dependency
  { source :: String
  , target :: String
  , relation :: String
  } deriving (Eq, Show)

proofSteps :: [ProofStep]
proofSteps =
  [ ProofStep "def_even" "n is even iff n = 2k for some integer k." "definition"
  , ProofStep "lemma_even_square" "If n is even, then n^2 is even." "direct proof"
  , ProofStep "rule_modus_ponens" "From P -> Q and P, infer Q." "inference rule"
  , ProofStep "rule_induction" "Base case plus successor step proves a natural-number claim." "inference rule"
  ]

proofDependencies :: [Dependency]
proofDependencies =
  [ Dependency "def_even" "lemma_even_square" "supports"
  , Dependency "rule_modus_ponens" "lemma_even_square" "background inference"
  , Dependency "rule_induction" "sum_first_n_formula" "justifies method"
  ]

proofDependencyCsv :: [String]
proofDependencyCsv =
  "source,target,relation"
  : [ intercalate "," [source dep, target dep, relation dep] | dep <- proofDependencies ]

differences :: [Integer] -> [Integer]
differences xs = zipWith (-) (drop 1 xs) xs

allSame :: Eq a => [a] -> Bool
allSame [] = False
allSame (x:xs) = all (== x) xs

classifySequence :: [Integer] -> String
classifySequence xs
  | length xs < 3 = "insufficient finite evidence"
  | allSame d1 = "arithmetic"
  | allSame d2 = "quadratic"
  | otherwise = "undetermined finite pattern"
  where
    d1 = differences xs
    d2 = differences d1

sequenceAudit :: [(String, [Integer])]
sequenceAudit =
  [ ("arithmetic", [2,5,8,11,14,17])
  , ("quadratic", [1,4,9,16,25,36])
  , ("misleading_prefix", [1,2,4,8,16,31])
  , ("triangular", [1,3,6,10,15,21])
  ]

sequenceAuditCsv :: [String]
sequenceAuditCsv =
  "sequence_name,terms,classification,first_differences,second_differences,interpretation"
  : [ intercalate ","
        [ name
        , quote (unwords (map show terms))
        , classifySequence terms
        , quote (unwords (map show (differences terms)))
        , quote (unwords (map show (differences (differences terms))))
        , quote "finite pattern classification supports conjecture but does not replace proof"
        ]
    | (name, terms) <- sequenceAudit
    ]

type Edge = (String, String)

vertices :: [Edge] -> [String]
vertices edges = sort . nub $ concat [[a,b] | (a,b) <- edges]

degree :: String -> [Edge] -> Int
degree v edges = length [() | (a,b) <- edges, a == v || b == v]

degreeSequence :: [Edge] -> [Int]
degreeSequence edges = reverse . sort $ [degree v edges | v <- vertices edges]

graphInvariantCsv :: [String]
graphInvariantCsv =
  let graphs =
        [ ("cycle4", [("a","b"),("b","c"),("c","d"),("d","a")])
        , ("path4", [("a","b"),("b","c"),("c","d")])
        , ("star4", [("o","a"),("o","b"),("o","c"),("o","d")])
        ]
   in "graph_id,vertex_count,edge_count,degree_sequence,interpretation"
      : [ intercalate ","
            [ name
            , show (length (vertices edges))
            , show (length edges)
            , quote (unwords (map show (degreeSequence edges)))
            , quote "degree sequence is useful but not a complete graph-isomorphism invariant"
            ]
        | (name, edges) <- graphs
        ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

writeLines :: FilePath -> [String] -> IO ()
writeLines path rows = writeFile path (unlines rows)

main :: IO ()
main = do
  putStrLn ("Haskell mathematical-thinking scaffold: " ++ articleSlug)
  putStrLn "Writing Haskell outputs into ../outputs/tables/"

  writeLines "../outputs/tables/haskell_truth_table.csv" truthTable
  writeLines "../outputs/tables/haskell_proof_dependencies.csv" proofDependencyCsv
  writeLines "../outputs/tables/haskell_sequence_audit.csv" sequenceAuditCsv
  writeLines "../outputs/tables/haskell_graph_invariants.csv" graphInvariantCsv

  putStrLn ("Proof steps modeled: " ++ show (length proofSteps))
  putStrLn "Done."
