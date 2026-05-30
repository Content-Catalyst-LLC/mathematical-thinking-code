{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- The Historical Understanding of Mathematics

module Main where

import Data.List (intercalate)

data Medium
  = Tablet
  | Papyrus
  | Diagram
  | Manuscript
  | PrintedBook
  | SymbolicNotation
  | Code
  | ProofScript
  deriving (Eq, Show)

data Method
  = Procedure
  | MeasurementRule
  | Demonstration
  | Commentary
  | SymbolicTransformation
  | LimitProof
  | StructuralComparison
  | Simulation
  | MachineCheck
  deriving (Eq, Show)

data HistoriographicRisk
  = Presentism
  | Eurocentrism
  | NotationAnachronism
  | TextualBias
  | CanonExclusion
  | FormalOverconfidence
  deriving (Eq, Show)

data HistoricalPractice = HistoricalPractice
  { practiceName :: String
  , objectOfThought :: String
  , medium :: Medium
  , method :: Method
  , meaning :: String
  , caution :: String
  } deriving (Eq, Show)

data Transmission = Transmission
  { sourceContext :: String
  , targetContext :: String
  , preservedContent :: String
  , transformedContent :: String
  } deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: HistoriographicRisk
  , problem :: String
  , mitigation :: String
  } deriving (Eq, Show)

practices :: [HistoricalPractice]
practices =
  [ HistoricalPractice "scribal calculation" "quantity and reciprocal relation" Tablet Procedure
      "administrative and computational reliability"
      "do not judge procedural mathematics only by later proof standards"
  , HistoricalPractice "measurement geometry" "length, area, volume, proportion" Papyrus MeasurementRule
      "land, construction, allocation, and administration"
      "surviving practical texts are partial evidence"
  , HistoricalPractice "Euclidean geometry" "space, figure, relation, construction" Diagram Demonstration
      "necessity under assumptions"
      "distinguish diagrammatic reasoning from later formal proof"
  , HistoricalPractice "symbolic algebra" "unknowns, equations, operations, symbolic form" SymbolicNotation SymbolicTransformation
      "generalization across problem families"
      "modern notation can distort older rhetorical practice"
  , HistoricalPractice "rigorous analysis" "limit, function, continuity, convergence" PrintedBook LimitProof
      "clarification of calculus and infinity"
      "do not project nineteenth-century rigor backward as the only standard"
  , HistoricalPractice "proof assistant formalization" "formal theorem and proof object" ProofScript MachineCheck
      "verified formal mathematical infrastructure"
      "formal statement must match intended meaning and assumptions"
  ]

transmissions :: [Transmission]
transmissions =
  [ Transmission "Greek mathematical texts" "Arabic-speaking scholarly worlds"
      "geometric propositions and astronomical models"
      "terminology, commentary, synthesis with algebra and astronomy"
  , Transmission "Indian numeral traditions" "Islamic and European mathematical cultures"
      "decimal place value and zero"
      "notation, pedagogy, commercial arithmetic, printed standardization"
  , Transmission "journal mathematics" "formal libraries and proof assistants"
      "theorems, definitions, proof strategies"
      "machine-checkable statements, dependencies, tactics, libraries"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord Presentism
      "older mathematics is judged only by modern notation or proof standards"
      "interpret practices within their own media, institutions, purposes, and standards"
  , RiskRecord Eurocentrism
      "mathematics is narrated mainly as a Greek-to-European sequence"
      "include multiple global traditions and transmission networks"
  , RiskRecord NotationAnachronism
      "modern notation is mistaken for original mathematical practice"
      "distinguish historical expression from modern reconstruction"
  , RiskRecord FormalOverconfidence
      "formal proof or verification is treated as full interpretation"
      "separate proof, specification, model, consequence, and use"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

practiceRows :: [String]
practiceRows =
  "practice,object_of_thought,medium,method,meaning,caution,interpretation"
  : [ intercalate ","
        [ quote (practiceName item)
        , quote (objectOfThought item)
        , show (medium item)
        , show (method item)
        , quote (meaning item)
        , quote (caution item)
        , quote "historical understanding links object, medium, method, and meaning"
        ]
    | item <- practices
    ]

transmissionRows :: [String]
transmissionRows =
  "source_context,target_context,preserved_content,transformed_content,interpretation"
  : [ intercalate ","
        [ quote (sourceContext item)
        , quote (targetContext item)
        , quote (preservedContent item)
        , quote (transformedContent item)
        , quote "transmission is preservation plus translation and transformation"
        ]
    | item <- transmissions
    ]

riskRows :: [String]
riskRows =
  "risk,problem,mitigation,interpretation"
  : [ intercalate ","
        [ show (risk item)
        , quote (problem item)
        , quote (mitigation item)
        , quote "historiographic risks should be explicit in mathematical-history work"
        ]
    | item <- risks
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell historical understanding scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_historical_practices.csv" practiceRows
  writeLines "../outputs/tables/haskell_transmission_records.csv" transmissionRows
  writeLines "../outputs/tables/haskell_historiographic_risks.csv" riskRows
  putStrLn "Done."
