{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and Scientific Modeling

module Main where

import Data.List (intercalate)

data ModelType
  = Mechanistic
  | Statistical
  | Simulation
  | AgentBased
  | Network
  | Systems
  | Hybrid
  | MachineLearningHybrid
  deriving (Eq, Show)

data ModelPurpose
  = Explanation
  | Prediction
  | ScenarioAnalysis
  | Control
  | Understanding
  | DecisionSupport
  deriving (Eq, Show)

data UncertaintySource
  = Measurement
  | Parameter
  | InitialCondition
  | Structural
  | Scenario
  | Numerical
  | DistributionShift
  deriving (Eq, Show)

data ModelRecord = ModelRecord
  { modelName :: String
  , modelType :: ModelType
  , purpose :: ModelPurpose
  , targetSystem :: String
  , uncertaintySources :: [UncertaintySource]
  , reviewQuestion :: String
  } deriving (Eq, Show)

data ModelRisk
  = FalsePrecision
  | ModelOverreach
  | HiddenAssumptions
  | DataBias
  | BlackBoxAuthority
  | PolicyMisuse
  | VisualRealism
  deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: ModelRisk
  , problem :: String
  , mitigation :: String
  } deriving (Eq, Show)

records :: [ModelRecord]
records =
  [ ModelRecord "predator-prey model" Mechanistic Understanding
      "interacting ecological populations"
      [Parameter, Structural]
      "Do simplified interaction rates hide ecological context?"
  , ModelRecord "epidemic model" Simulation DecisionSupport
      "disease spread in a population"
      [Measurement, Parameter, Scenario, Structural]
      "Are behavior change and reporting uncertainty represented?"
  , ModelRecord "climate scenario model" Hybrid ScenarioAnalysis
      "coupled Earth system and human forcing pathways"
      [Parameter, InitialCondition, Structural, Scenario, Numerical]
      "Are scenario assumptions and uncertainty communicated clearly?"
  , ModelRecord "AI surrogate model" MachineLearningHybrid Prediction
      "expensive simulation emulator"
      [Parameter, DistributionShift, Structural]
      "Is the surrogate valid across the intended parameter range?"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord FalsePrecision
      "numerical output appears more certain than it is"
      "report uncertainty assumptions and validity scope"
  , RiskRecord ModelOverreach
      "model is used beyond its intended domain"
      "state intended use scope limits and invalid use cases"
  , RiskRecord HiddenAssumptions
      "simplifications are buried inside technical form"
      "document assumptions explicitly and test alternatives"
  , RiskRecord DataBias
      "input data misrepresent the target system"
      "audit measurement sampling exclusions and missing data"
  , RiskRecord BlackBoxAuthority
      "model cannot be inspected or explained"
      "require transparency testing interpretability and independent review"
  , RiskRecord PolicyMisuse
      "model is treated as decision rather than decision support"
      "separate model evidence from values governance and policy judgment"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

sourceList :: [UncertaintySource] -> String
sourceList items = intercalate "|" (map show items)

recordRows :: [String]
recordRows =
  "model_name,model_type,purpose,target_system,uncertainty_sources,review_question,interpretation"
  : [ intercalate ","
        [ quote (modelName item)
        , show (modelType item)
        , show (purpose item)
        , quote (targetSystem item)
        , quote (sourceList (uncertaintySources item))
        , quote (reviewQuestion item)
        , quote "model purpose determines appropriate validation and interpretation"
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
        , quote "scientific models require transparency uncertainty and responsible interpretation"
        ]
    | item <- risks
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "Represent,\"What system variables boundaries and assumptions are chosen?\",\"model frames the wrong problem\""
  , "Relate,\"How do variables mechanisms and uncertainties interact?\",\"relationships are oversimplified or unjustified\""
  , "Test,\"How does the model compare with evidence and alternatives?\",\"fit is mistaken for validity\""
  , "Revise,\"What must change in light of error uncertainty or new use?\",\"model becomes frozen despite changing evidence\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell scientific modeling scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_model_records.csv" recordRows
  writeLines "../outputs/tables/haskell_model_risks.csv" riskRows
  writeLines "../outputs/tables/haskell_represent_relate_test_revise.csv" workflowRows
  putStrLn "Done."
