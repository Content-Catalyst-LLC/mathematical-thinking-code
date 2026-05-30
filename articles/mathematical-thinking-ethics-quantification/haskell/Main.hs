{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and the Ethics of Quantification

module Main where

import Data.List (intercalate)

data MetricType
  = Measurement
  | Indicator
  | Proxy
  | Score
  | Ranking
  | RiskScore
  | Benchmark
  deriving (Eq, Show)

data ConsequenceLevel
  = LowStakes
  | ModerateStakes
  | HighStakes
  deriving (Eq, Show)

data MetricRisk
  = FalsePrecision
  | ProxySubstitution
  | GoodhartDistortion
  | HiddenInequality
  | RankingInstability
  | ContextErasure
  | UnaccountableUse
  | QuantifiedDisadvantage
  deriving (Eq, Show)

data MetricRecord = MetricRecord
  { metricName :: String
  , metricType :: MetricType
  , targetConcept :: String
  , consequenceLevel :: ConsequenceLevel
  , risks :: [MetricRisk]
  , reviewQuestion :: String
  } deriving (Eq, Show)

records :: [MetricRecord]
records =
  [ MetricRecord "student test score" Proxy "learning" HighStakes
      [ProxySubstitution, GoodhartDistortion, HiddenInequality]
      "Does the score represent learning fairly across students and contexts?"
  , MetricRecord "research citation count" Indicator "research influence or quality" ModerateStakes
      [ProxySubstitution, ContextErasure, GoodhartDistortion]
      "Does the metric support expert judgment rather than replace it?"
  , MetricRecord "AI benchmark score" Benchmark "model capability" HighStakes
      [GoodhartDistortion, FalsePrecision, ContextErasure]
      "Does the benchmark represent real deployment risks?"
  , MetricRecord "credit risk score" RiskScore "loan repayment risk" HighStakes
      [QuantifiedDisadvantage, ContextErasure, UnaccountableUse]
      "Does the score amplify historical exclusion or allow meaningful contestation?"
  , MetricRecord "composite sustainability score" Score "sustainability performance" HighStakes
      [ProxySubstitution, HiddenInequality, ContextErasure]
      "Does the composite score hide component-level ecological or justice harms?"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

riskList :: [MetricRisk] -> String
riskList items = intercalate "|" (map show items)

recordRows :: [String]
recordRows =
  "metric_name,metric_type,target_concept,consequence_level,risks,review_question,interpretation"
  : [ intercalate ","
        [ quote (metricName item)
        , show (metricType item)
        , quote (targetConcept item)
        , show (consequenceLevel item)
        , quote (riskList (risks item))
        , quote (reviewQuestion item)
        , quote "metric consequence level determines validity governance and contestability requirements"
        ]
    | item <- records
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "Define,\"What concept is being quantified?\",\"metric has no clear meaning\""
  , "Measure,\"How is the concept represented numerically?\",\"proxy does not match value\""
  , "Contextualize,\"What background uncertainty and limits matter?\",\"number is interpreted as self-explanatory\""
  , "Govern,\"How will the number be used audited and challenged?\",\"metric becomes unaccountable power\""
  , "Justice,\"Who may be harmed excluded or misrepresented?\",\"metric hides unequal consequences\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell quantification ethics scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_metric_records.csv" recordRows
  writeLines "../outputs/tables/haskell_define_measure_contextualize_govern.csv" workflowRows
  putStrLn "Done."
