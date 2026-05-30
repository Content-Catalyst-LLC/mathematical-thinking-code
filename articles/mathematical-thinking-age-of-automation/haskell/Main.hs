{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking in an Age of Automation

module Main where

import Data.List (intercalate)

data AutomationType
  = Calculator
  | ComputerAlgebra
  | NumericalSimulation
  | AIAssistant
  | ProofAssistant
  deriving (Eq, Show)

data OutputType
  = ArithmeticOutput
  | SymbolicTransformation
  | SimulationTrajectory
  | AIExplanation
  | MachineCheckedDerivation
  deriving (Eq, Show)

data EvidenceStandard
  = ArithmeticCheck
  | SymbolicEquivalence
  | NumericalValidation
  | IndependentReview
  | MachineCheckedProof
  deriving (Eq, Show)

data AutomationRisk
  = FluentFalsehood
  | HiddenAssumptions
  | ModelOverreach
  | OptimizationHarm
  | FormalMismatch
  | SkillErosion
  deriving (Eq, Show)

data AutomationRecord = AutomationRecord
  { task :: String
  , tool :: AutomationType
  , output :: OutputType
  , evidence :: EvidenceStandard
  , humanResponsibility :: String
  } deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: AutomationRisk
  , problem :: String
  , mitigation :: String
  } deriving (Eq, Show)

records :: [AutomationRecord]
records =
  [ AutomationRecord "calculate physical quantity" Calculator ArithmeticOutput ArithmeticCheck
      "check quantity, units, operation, and reasonableness"
  , AutomationRecord "simplify symbolic expression" ComputerAlgebra SymbolicTransformation SymbolicEquivalence
      "check domains, branches, and assumptions"
  , AutomationRecord "simulate dynamical system" NumericalSimulation SimulationTrajectory NumericalValidation
      "check stability, sensitivity, convergence, and validation"
  , AutomationRecord "generate proof outline" AIAssistant AIExplanation IndependentReview
      "verify every mathematical claim independently"
  , AutomationRecord "check theorem" ProofAssistant MachineCheckedDerivation MachineCheckedProof
      "review formal statement, libraries, kernel, and intended meaning"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord FluentFalsehood
      "convincing explanation with invalid reasoning"
      "check definitions, steps, examples, and proof obligations"
  , RiskRecord HiddenAssumptions
      "output is valid only under unstated conditions"
      "document domain, constraints, parameters, data, and libraries"
  , RiskRecord ModelOverreach
      "formal model treated as reality"
      "validate model, state limitations, and run sensitivity checks"
  , RiskRecord FormalMismatch
      "verified theorem differs from intended informal claim"
      "review formal statement, definitions, theorem scope, and library assumptions"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

recordRows :: [String]
recordRows =
  "task,tool,output_type,evidence_standard,human_responsibility,interpretation"
  : [ intercalate ","
        [ quote (task item)
        , show (tool item)
        , show (output item)
        , show (evidence item)
        , quote (humanResponsibility item)
        , quote "automation extends mathematical capacity but requires human verification and interpretation"
        ]
    | item <- records
    ]

riskRows :: [String]
riskRows =
  "risk,problem,mitigation,interpretation"
  : [ intercalate ","
        [ show (risk item)
        , quote (problem item)
        , quote (mitigation item)
        , quote "automation risk should be mitigated through assumption review and independent checking"
        ]
    | item <- risks
    ]

stageRows :: [String]
stageRows =
  [ "stage,question,failure_mode"
  , "Specify,\"What exactly is the problem?\",\"wrong question answered precisely\""
  , "Compute,\"What system or method produced the output?\",\"opaque automation\""
  , "Verify,\"How do we know the result is correct or adequate?\",\"unchallenged output\""
  , "Interpret,\"What does the result mean in context?\",\"formal correctness without meaning\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell automation scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_automation_records.csv" recordRows
  writeLines "../outputs/tables/haskell_automation_risks.csv" riskRows
  writeLines "../outputs/tables/haskell_specify_compute_verify_interpret.csv" stageRows
  putStrLn "Done."
