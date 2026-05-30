{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Historical Development and the Unity of Mathematical Ideas

module Main where

import Data.List (intercalate)

data MathematicalMode
  = Arithmetic
  | Geometric
  | Algebraic
  | Analytic
  | Structural
  | Logical
  | Probabilistic
  | Computational
  | AppliedModeling
  deriving (Eq, Show)

data UnifyingIdea
  = Pattern
  | Quantity
  | Relation
  | Transformation
  | Invariance
  | Proof
  | Algorithm
  | Model
  deriving (Eq, Show)

data EvidenceStandard
  = Demonstration
  | FormalDerivation
  | AlgorithmicCorrectness
  | ModelValidation
  | SimulationEvidence
  | MachineCheckedProof
  deriving (Eq, Show)

data Concept = Concept
  { conceptName :: String
  , mode :: MathematicalMode
  , idea :: UnifyingIdea
  , transformation :: String
  , preserved :: String
  , interpretation :: String
  } deriving (Eq, Show)

data Connection = Connection
  { source :: String
  , target :: String
  , connectionType :: String
  , preservedStructure :: String
  , caution :: String
  } deriving (Eq, Show)

data GeneralizationWarning = GeneralizationWarning
  { topic :: String
  , warning :: String
  , mitigation :: String
  } deriving (Eq, Show)

concepts :: [Concept]
concepts =
  [ Concept "quantity" Arithmetic Quantity "calculation and comparison"
      "same numerical form across different objects"
      "quantity abstracts from the thing counted or measured"
  , Concept "proportion" Geometric Relation "scaling"
      "same relative relation"
      "proportion connects number, shape, and similarity"
  , Concept "proof" Logical Proof "valid inference"
      "truth under accepted rules and assumptions"
      "proof makes reasoning accountable"
  , Concept "algorithm" Computational Algorithm "execution"
      "specified input-output behavior"
      "algorithms make mathematical procedures repeatable"
  , Concept "derivative" Analytic Transformation "differentiation"
      "local linear behavior"
      "derivatives unify geometry and change"
  , Concept "group" Algebraic Invariance "homomorphism"
      "operation structure"
      "groups unify symmetry and algebraic law"
  , Concept "graph" Structural Relation "graph morphism"
      "adjacency or connectivity pattern"
      "graphs unify networks, dependencies, and finite relations"
  , Concept "model" AppliedModeling Model "validation and simulation"
      "selected relation between formal system and target system"
      "models require interpretation and assumptions"
  ]

connections :: [Connection]
connections =
  [ Connection "proportion" "slope" "historical and conceptual generalization"
      "ratio relation"
      "slope includes coordinate interpretation beyond simple proportion"
  , Connection "curve" "equation" "representation translation"
      "point relation"
      "geometric intuition may not transfer cleanly into algebraic form"
  , Connection "group" "symmetry" "structural identification"
      "operation and inverse structure"
      "symmetry depends on allowed transformations"
  , Connection "proof" "formal verification" "medium transformation"
      "derivation under rules"
      "verified formal statement may not match intended informal claim"
  ]

warnings :: [GeneralizationWarning]
warnings =
  [ GeneralizationWarning "formal similarity"
      "different systems may be treated as the same because their formal models resemble one another"
      "ask what the structure preserves, omits, and changes"
  , GeneralizationWarning "model transfer"
      "a model may be transferred to a new domain without validating assumptions"
      "revalidate data, assumptions, interpretation, and consequences"
  , GeneralizationWarning "historical flattening"
      "different mathematical traditions may be forced into one modern framework"
      "preserve historical specificity while identifying shared ideas carefully"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

conceptRows :: [String]
conceptRows =
  "concept,mode,unifying_idea,transformation,preserved,interpretation"
  : [ intercalate ","
        [ quote (conceptName item)
        , show (mode item)
        , show (idea item)
        , quote (transformation item)
        , quote (preserved item)
        , quote (interpretation item)
        ]
    | item <- concepts
    ]

connectionRows :: [String]
connectionRows =
  "source,target,connection_type,preserved_structure,caution,interpretation"
  : [ intercalate ","
        [ quote (source item)
        , quote (target item)
        , quote (connectionType item)
        , quote (preservedStructure item)
        , quote (caution item)
        , quote "conceptual migration should not be confused with contextual sameness"
        ]
    | item <- connections
    ]

warningRows :: [String]
warningRows =
  "topic,warning,mitigation,interpretation"
  : [ intercalate ","
        [ quote (topic item)
        , quote (warning item)
        , quote (mitigation item)
        , quote "responsible unity asks what is preserved and what is omitted"
        ]
    | item <- warnings
    ]

evidenceRows :: [String]
evidenceRows =
  "evidence_standard,interpretation"
  : [ intercalate ","
        [ show standard
        , quote "proof, algorithm, model, simulation, and verification require distinct evidence standards"
        ]
    | standard <- [Demonstration, FormalDerivation, AlgorithmicCorrectness, ModelValidation, SimulationEvidence, MachineCheckedProof]
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell mathematical-unity scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_unifying_concepts.csv" conceptRows
  writeLines "../outputs/tables/haskell_cross_field_connections.csv" connectionRows
  writeLines "../outputs/tables/haskell_generalization_warnings.csv" warningRows
  writeLines "../outputs/tables/haskell_evidence_standards.csv" evidenceRows
  putStrLn "Done."
