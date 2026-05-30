{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and Proof Assistants

module Main where

import Data.List (intercalate)

data ProofLayer
  = Concept
  | Definition
  | TheoremStatement
  | ProofConstruction
  | MachineCheck
  | Interpretation
  deriving (Eq, Show)

data TrustBoundary
  = FormalStatement
  | Kernel
  | Axioms
  | Libraries
  | Foundations
  | HumanMeaning
  deriving (Eq, Show)

data ProofAssistantSystem
  = Lean
  | Rocq
  | IsabelleHOL
  | HOLLight
  | Mizar
  | Agda
  | Metamath
  deriving (Eq, Show)

data FormalizationRisk
  = FormalMismatch
  | HiddenAssumption
  | OpaqueProofScript
  | BadDefinition
  | MisunderstoodTrustBoundary
  | InterpretationLoss
  deriving (Eq, Show)

data ProofAssistantRecord = ProofAssistantRecord
  { layer :: ProofLayer
  , humanRole :: String
  , machineRole :: String
  , trustBoundary :: TrustBoundary
  , risk :: FormalizationRisk
  } deriving (Eq, Show)

data SystemRecord = SystemRecord
  { system :: ProofAssistantSystem
  , foundation :: String
  , strength :: String
  , reviewNote :: String
  } deriving (Eq, Show)

records :: [ProofAssistantRecord]
records =
  [ ProofAssistantRecord Concept
      "choose the mathematical problem and why it matters"
      "no independent mathematical purpose"
      HumanMeaning
      InterpretationLoss
  , ProofAssistantRecord Definition
      "encode objects and assumptions"
      "check syntax and type correctness"
      FormalStatement
      BadDefinition
  , ProofAssistantRecord TheoremStatement
      "state the intended theorem precisely"
      "represent the proposition in formal language"
      FormalStatement
      FormalMismatch
  , ProofAssistantRecord ProofConstruction
      "guide proof strategy and lemma selection"
      "track goals and accept valid steps"
      Kernel
      OpaqueProofScript
  , ProofAssistantRecord MachineCheck
      "understand trusted components"
      "check derivation under formal rules"
      Kernel
      MisunderstoodTrustBoundary
  , ProofAssistantRecord Interpretation
      "explain significance, scope, and limitations"
      "no contextual or ethical judgment"
      HumanMeaning
      InterpretationLoss
  ]

systems :: [SystemRecord]
systems =
  [ SystemRecord Lean "dependent type theory"
      "large modern mathematics library and active community"
      "review formal statement, imported libraries, kernel, and accepted axioms"
  , SystemRecord Rocq "calculus of inductive constructions"
      "dependent type theory and constructive formalization"
      "review constructive assumptions, extraction pipeline, libraries, and kernel"
  , SystemRecord IsabelleHOL "higher-order logic"
      "mature automation and structured proof"
      "review object logic, automation, imported theories, and formal statement"
  , SystemRecord HOLLight "classical higher-order logic"
      "small trusted core and landmark formalizations"
      "review core, axioms, definitions, and theorem statement"
  , SystemRecord Mizar "set-theoretic declarative formalization"
      "long-standing mathematical library"
      "review definitions, library dependencies, and article environment"
  , SystemRecord Agda "dependent type theory"
      "constructive mathematics and dependently typed programming"
      "review termination, types, constructive commitments, and formal meaning"
  , SystemRecord Metamath "minimal formal proof framework"
      "foundational transparency and explicit proof databases"
      "review axioms, compressed proof checking, and database dependencies"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

recordRows :: [String]
recordRows =
  "layer,human_role,machine_role,trust_boundary,risk,interpretation"
  : [ intercalate ","
        [ show (layer item)
        , quote (humanRole item)
        , quote (machineRole item)
        , show (trustBoundary item)
        , show (risk item)
        , quote "proof assistants check formal derivations while humans preserve meaning"
        ]
    | item <- records
    ]

systemRows :: [String]
systemRows =
  "system,foundation,strength,review_note,interpretation"
  : [ intercalate ","
        [ show (system item)
        , quote (foundation item)
        , quote (strength item)
        , quote (reviewNote item)
        , quote "system choice shapes foundation, automation, libraries, and trust"
        ]
    | item <- systems
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "Define,\"What objects and structures are being used?\",\"bad definitions make proofs awkward or misleading\""
  , "State,\"What exactly is the theorem?\",\"formal statement misses informal meaning\""
  , "Prove,\"How is the derivation constructed?\",\"proof script becomes fragile or opaque\""
  , "Check,\"What does the system verify?\",\"trust boundary is misunderstood\""
  , "Interpret,\"What does the theorem mean?\",\"formal correctness replaces explanation\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell proof-assistant scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_proof_assistant_records.csv" recordRows
  writeLines "../outputs/tables/haskell_proof_assistant_systems.csv" systemRows
  writeLines "../outputs/tables/haskell_define_state_prove_check_interpret.csv" workflowRows
  putStrLn "Done."
