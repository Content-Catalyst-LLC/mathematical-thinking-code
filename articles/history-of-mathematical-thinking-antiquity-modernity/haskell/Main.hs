{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- The History of Mathematical Thinking from Antiquity to Modernity

module Main where

import Data.List (intercalate)

data ThinkingMode
  = Procedural
  | Diagrammatic
  | Deductive
  | Algebraic
  | Analytic
  | Structural
  | Computational
  | FormalVerified
  deriving (Eq, Show)

data Medium
  = Tablet
  | Papyrus
  | Diagram
  | Manuscript
  | PrintedBook
  | JournalArticle
  | Code
  | ProofScript
  deriving (Eq, Show)

data Milestone = Milestone
  { milestoneId :: String
  , periodName :: String
  , traditionName :: String
  , mode :: ThinkingMode
  , medium :: Medium
  , contribution :: String
  , caution :: String
  } deriving (Eq, Show)

data Structure = Structure
  { structureName :: String
  , objects :: String
  , operationsOrRelations :: String
  , thinkingShift :: String
  } deriving (Eq, Show)

data HistoriographicWarning = HistoriographicWarning
  { warningTopic :: String
  , warningText :: String
  , mitigation :: String
  } deriving (Eq, Show)

milestones :: [Milestone]
milestones =
  [ Milestone "ms_mesopotamian_tables" "Antiquity" "Mesopotamian" Procedural Tablet
      "place-value computation, tables, reciprocal methods"
      "do not confuse modern algebraic reconstruction with original notation"
  , Milestone "ms_egyptian_measurement" "Antiquity" "Egyptian" Procedural Papyrus
      "fraction methods, area and volume rules, administrative arithmetic"
      "surviving texts are partial evidence of broader practice"
  , Milestone "ms_greek_deduction" "Classical antiquity" "Greek" Deductive Diagram
      "axiomatic geometry and proposition-proof architecture"
      "deductive proof is central but not the only historical form of mathematical reasoning"
  , Milestone "ms_indian_place_value" "Classical-medieval" "Indian" Algebraic Manuscript
      "zero, decimal place value, algorithmic arithmetic, astronomy, trigonometry"
      "recognize distinct genres of rule, verse, commentary, and justification"
  , Milestone "ms_chinese_systems" "Classical-medieval" "Chinese" Procedural Manuscript
      "linear systems, rod calculation, dissection, configurational reasoning"
      "procedural verification deserves serious mathematical interpretation"
  , Milestone "ms_islamic_algebra" "Medieval" "Islamic" Algebraic Manuscript
      "algebra, trigonometry, translation, astronomy"
      "transmission was also creative transformation"
  , Milestone "ms_calculus_coordinates" "Early modern" "European" Analytic PrintedBook
      "analytic geometry, calculus, mechanics, probability"
      "mathematical models require interpretation and assumptions"
  , Milestone "ms_structural_modern" "Twentieth century" "International" Structural JournalArticle
      "groups, rings, fields, topology, categories, graphs"
      "abstraction should remain connected to examples and access"
  , Milestone "ms_proof_assistants" "Contemporary" "Computational" FormalVerified ProofScript
      "proof assistants, formal verification, machine-checked libraries"
      "formal verification depends on human definitions, specifications, and interpretation"
  ]

structures :: [Structure]
structures =
  [ Structure "Group" "elements such as symmetries or transformations"
      "one associative operation with identity and inverses"
      "from objects to operation laws"
  , Structure "Vector space" "vectors, functions, signals, or data points"
      "addition and scalar multiplication"
      "from individual quantities to linear structure"
  , Structure "Graph" "vertices and edges"
      "adjacency, connectivity, paths"
      "from quantities to relations"
  , Structure "Formal system" "symbols, formulas, axioms, proofs"
      "inference rules and derivations"
      "from using proof to studying proof"
  ]

warnings :: [HistoriographicWarning]
warnings =
  [ HistoriographicWarning "canon formation"
      "mathematical history can be reduced to a Greek-European sequence"
      "include multiple global traditions and mathematical media"
  , HistoriographicWarning "presentism"
      "older mathematics can be judged only by modern notation, proof, or rigor standards"
      "interpret practices within their historical contexts"
  , HistoriographicWarning "modern computation"
      "formalization and proof assistants can be treated as the inevitable final form of mathematics"
      "recognize computation as a powerful medium still dependent on human meaning"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

milestoneRows :: [String]
milestoneRows =
  "milestone_id,period,tradition,thinking_mode,medium,contribution,caution,interpretation"
  : [ intercalate ","
        [ quote (milestoneId item)
        , quote (periodName item)
        , quote (traditionName item)
        , show (mode item)
        , show (medium item)
        , quote (contribution item)
        , quote (caution item)
        , quote "typed historical metadata supports comparison without ranking"
        ]
    | item <- milestones
    ]

structureRows :: [String]
structureRows =
  "structure,objects,operations_or_relations,thinking_shift,interpretation"
  : [ intercalate ","
        [ quote (structureName item)
        , quote (objects item)
        , quote (operationsOrRelations item)
        , quote (thinkingShift item)
        , quote "modern mathematics often studies objects through relations, operations, and laws"
        ]
    | item <- structures
    ]

warningRows :: [String]
warningRows =
  "topic,warning,mitigation,interpretation"
  : [ intercalate ","
        [ quote (warningTopic item)
        , quote (warningText item)
        , quote (mitigation item)
        , quote "historiographic risks should be explicit in mathematical-history work"
        ]
    | item <- warnings
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell history of mathematical thinking scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_historical_milestones.csv" milestoneRows
  writeLines "../outputs/tables/haskell_structural_abstractions.csv" structureRows
  writeLines "../outputs/tables/haskell_historiographic_warnings.csv" warningRows
  putStrLn "Done."
