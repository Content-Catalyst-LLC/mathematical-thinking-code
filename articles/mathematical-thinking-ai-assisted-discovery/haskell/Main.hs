{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and AI-Assisted Discovery

module Main where

import Data.List (intercalate)

data CandidateType
  = Example
  | Conjecture
  | Program
  | ProofSketch
  | FormalStatement
  | FormalProofScript
  deriving (Eq, Show)

data EvidenceStatus
  = Untested
  | TestedFiniteCases
  | CounterexampleFound
  | InformallyProved
  | MachineChecked
  | Rejected
  | MachineCheckRequired
  deriving (Eq, Show)

data DiscoveryStage
  = Generate
  | Test
  | Prove
  | Interpret
  deriving (Eq, Show)

data DiscoveryRisk
  = FluentFalsehood
  | FalseConjecture
  | EvaluatorOverfitting
  | FormalMismatch
  | FalseNovelty
  | CreditDistortion
  | UninterpretableCandidate
  deriving (Eq, Show)

data DiscoveryRecord = DiscoveryRecord
  { candidateName :: String
  , candidateType :: CandidateType
  , stage :: DiscoveryStage
  , evidenceStatus :: EvidenceStatus
  , humanReview :: String
  } deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: DiscoveryRisk
  , mathematicalProblem :: String
  , mitigation :: String
  } deriving (Eq, Show)

records :: [DiscoveryRecord]
records =
  [ DiscoveryRecord "graph invariant pattern" Conjecture Test TestedFiniteCases
      "search for counterexamples and identify missing hypotheses"
  , DiscoveryRecord "candidate construction program" Program Test TestedFiniteCases
      "inspect code and ask whether the construction has a proof"
  , DiscoveryRecord "proof outline" ProofSketch Prove Untested
      "check every inference independently"
  , DiscoveryRecord "formal theorem statement" FormalStatement Prove Untested
      "verify that the formal statement matches intended meaning"
  , DiscoveryRecord "accepted proof script candidate" FormalProofScript Interpret MachineCheckRequired
      "run the proof assistant and review theorem significance and scope"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord FluentFalsehood
      "generated explanation sounds correct but contains invalid reasoning"
      "check every inference against definitions and proof obligations"
  , RiskRecord FalseConjecture
      "pattern fails outside tested examples"
      "search counterexamples, refine hypotheses, and prove or disprove"
  , RiskRecord EvaluatorOverfitting
      "system optimizes a narrow metric rather than the mathematical problem"
      "use multiple evaluators, held-out cases, and human interpretation"
  , RiskRecord FormalMismatch
      "formal statement differs from intended theorem"
      "translate formal statement back into prose and review hypotheses"
  , RiskRecord FalseNovelty
      "known result appears new because literature was not checked"
      "perform literature search and expert consultation"
  , RiskRecord CreditDistortion
      "human, community, library, or dataset labor is obscured"
      "document tools, prompts, datasets, evaluators, libraries, proof labor, and human roles"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

recordRows :: [String]
recordRows =
  "candidate_name,candidate_type,stage,evidence_status,human_review,interpretation"
  : [ intercalate ","
        [ quote (candidateName item)
        , show (candidateType item)
        , show (stage item)
        , show (evidenceStatus item)
        , quote (humanReview item)
        , quote "AI output is candidate material until tested, proved, and interpreted"
        ]
    | item <- records
    ]

riskRows :: [String]
riskRows =
  "risk,mathematical_problem,mitigation,interpretation"
  : [ intercalate ","
        [ show (risk item)
        , quote (mathematicalProblem item)
        , quote (mitigation item)
        , quote "responsible AI-assisted discovery requires verification and documentation"
        ]
    | item <- risks
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "Generate,\"What candidate was produced?\",\"fluent but false or irrelevant output\""
  , "Test,\"What evidence supports or challenges the candidate?\",\"overfitting to finite cases or a narrow evaluator\""
  , "Prove,\"Can the claim be established rigorously?\",\"proof gap, hidden assumption, or formal mismatch\""
  , "Interpret,\"What does the result mean and why does it matter?\",\"novel output without mathematical significance\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell AI-assisted discovery scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_discovery_records.csv" recordRows
  writeLines "../outputs/tables/haskell_discovery_risks.csv" riskRows
  writeLines "../outputs/tables/haskell_generate_test_prove_interpret.csv" workflowRows
  putStrLn "Done."
