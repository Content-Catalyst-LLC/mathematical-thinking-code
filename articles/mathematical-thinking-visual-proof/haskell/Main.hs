{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and Visual Proof

module Main where

import Data.List (intercalate)

data VisualRole
  = Illustration
  | Evidence
  | Heuristic
  | DiagrammaticArgument
  | FormalDiagrammaticProof
  deriving (Eq, Show)

data VisualDomain
  = Geometry
  | Algebra
  | Combinatorics
  | GraphTheory
  | Calculus
  | CategoryDiagram
  deriving (Eq, Show)

data ProofStatus
  = VisualOnly
  | NeedsGeneralization
  | NeedsFormalLimit
  | InformallyJustified
  | FormallyExpressible
  | FormallyProved
  deriving (Eq, Show)

data VisualRisk
  = SpecialCase
  | ScaleIllusion
  | HiddenAssumption
  | AccidentalAlignment
  | FinitePatternOverreach
  | AccessibilityGap
  deriving (Eq, Show)

data VisualProofRecord = VisualProofRecord
  { title :: String
  , domain :: VisualDomain
  , role :: VisualRole
  , status :: ProofStatus
  , humanReview :: String
  } deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: VisualRisk
  , problem :: String
  , mitigation :: String
  } deriving (Eq, Show)

records :: [VisualProofRecord]
records =
  [ VisualProofRecord "odd sums as square layers" Combinatorics DiagrammaticArgument InformallyJustified
      "state why the layer pattern holds for arbitrary n"
  , VisualProofRecord "binomial square area model" Algebra DiagrammaticArgument InformallyJustified
      "show area preservation and identify all parts"
  , VisualProofRecord "dynamic geometry invariant" Geometry Heuristic NeedsGeneralization
      "derive invariant from construction"
  , VisualProofRecord "graph drawing connectivity" GraphTheory Evidence NeedsGeneralization
      "separate drawing from abstract graph"
  , VisualProofRecord "derivative as limiting secants" Calculus Heuristic NeedsFormalLimit
      "state the limit definition"
  , VisualProofRecord "commutative square" CategoryDiagram FormalDiagrammaticProof FormallyExpressible
      "state the equality of compositions"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord SpecialCase
      "diagram represents only one configuration"
      "vary the case and identify invariant relations"
  , RiskRecord ScaleIllusion
      "graph or figure distorts relation through scale"
      "check axes units and numerical values"
  , RiskRecord HiddenAssumption
      "argument depends on unstated condition"
      "list hypotheses and exceptional cases"
  , RiskRecord AccidentalAlignment
      "points or lines appear related because of drawing choices"
      "derive relation from construction"
  , RiskRecord FinitePatternOverreach
      "early examples suggest false generalization"
      "search counterexamples and prove general structure"
  , RiskRecord AccessibilityGap
      "visual argument is not available in nonvisual form"
      "provide verbal symbolic and structural description"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

recordRows :: [String]
recordRows =
  "title,domain,visual_role,proof_status,human_review,interpretation"
  : [ intercalate ","
        [ quote (title item)
        , show (domain item)
        , show (role item)
        , show (status item)
        , quote (humanReview item)
        , quote "visual insight becomes proof through abstraction and justification"
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
        , quote "visual proof requires generality review and accessible explanation"
        ]
    | item <- risks
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "See,\"What pattern relation or structure is visible?\",\"noticing only a special case\""
  , "Abstract,\"What is essential and what is accidental?\",\"confusing drawing features with theorem conditions\""
  , "Prove,\"Why does the relation hold generally?\",\"visual plausibility without justification\""
  , "Interpret,\"What does the proof reveal?\",\"diagram treated as decoration rather than reasoning\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell visual proof scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_visual_proof_records.csv" recordRows
  writeLines "../outputs/tables/haskell_visual_risks.csv" riskRows
  writeLines "../outputs/tables/haskell_see_abstract_prove_interpret.csv" workflowRows
  putStrLn "Done."
