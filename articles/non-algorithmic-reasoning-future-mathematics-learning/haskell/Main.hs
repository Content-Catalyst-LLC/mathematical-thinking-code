{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Non-Algorithmic Reasoning and the Future of Mathematics Learning

module Main where

import Data.List (intercalate)

data ReasoningStage
  = Notice
  | Frame
  | Represent
  | Reason
  | Justify
  | Reflect
  deriving (Eq, Show)

data ReasoningMove = ReasoningMove
  { moveId :: String
  , stage :: ReasoningStage
  , guidingQuestion :: String
  , mathematicalRole :: String
  } deriving (Eq, Show)

data SolutionAudit = SolutionAudit
  { auditId :: String
  , taskId :: String
  , methodName :: String
  , assumptionsChecked :: Bool
  , interpretationGiven :: Bool
  , justificationGiven :: Bool
  , reflectionGiven :: Bool
  } deriving (Eq, Show)

quality :: SolutionAudit -> String
quality audit
  | assumptionsChecked audit && interpretationGiven audit && justificationGiven audit && reflectionGiven audit = "strong non-algorithmic reasoning"
  | justificationGiven audit && assumptionsChecked audit = "partially justified"
  | otherwise = "procedural or incomplete"

score :: SolutionAudit -> Int
score audit =
  sum
    [ if assumptionsChecked audit then 1 else 0
    , if interpretationGiven audit then 1 else 0
    , if justificationGiven audit then 1 else 0
    , if reflectionGiven audit then 1 else 0
    ]

moves :: [ReasoningMove]
moves =
  [ ReasoningMove "notice_pattern" Notice "What pattern or structure appears?" "initiates conjecture and exploration"
  , ReasoningMove "frame_problem" Frame "What is the mathematical problem?" "clarifies object goal constraints and assumptions"
  , ReasoningMove "choose_representation" Represent "Which representation makes the structure visible?" "supports flexible mathematical reasoning"
  , ReasoningMove "verify_output" Justify "Does the answer satisfy the original problem?" "connects procedure output to validation"
  , ReasoningMove "reflect_transfer" Reflect "What transfers to new problems?" "builds metacognitive transfer"
  ]

audits :: [SolutionAudit]
audits =
  [ SolutionAudit "audit_a" "task_quadratic_roots" "quadratic formula" True False True False
  , SolutionAudit "audit_b" "task_false_generalization" "finite testing" False False False False
  , SolutionAudit "audit_c" "task_quadratic_roots" "factoring and verification" True True True True
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

moveRows :: [String]
moveRows =
  "move_id,stage,guiding_question,mathematical_role"
  : [ intercalate ","
        [ moveId m
        , show (stage m)
        , quote (guidingQuestion m)
        , quote (mathematicalRole m)
        ]
    | m <- moves
    ]

auditRows :: [String]
auditRows =
  "audit_id,task_id,method_name,score,quality"
  : [ intercalate ","
        [ auditId a
        , taskId a
        , quote (methodName a)
        , show (score a)
        , quote (quality a)
        ]
    | a <- audits
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell non-algorithmic reasoning scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_reasoning_moves.csv" moveRows
  writeLines "../outputs/tables/haskell_solution_audits.csv" auditRows
  putStrLn "Done."
