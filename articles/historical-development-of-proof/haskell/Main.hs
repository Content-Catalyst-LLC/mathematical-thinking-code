{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- The Historical Development of Proof

module Main where

import Data.List (intercalate)

data ProofStyle
  = Procedural
  | Diagrammatic
  | Deductive
  | Algebraic
  | Analytic
  | FormalLogical
  | MachineChecked
  deriving (Eq, Show)

data Medium
  = Tablet
  | Papyrus
  | Diagram
  | Commentary
  | PrintedBook
  | JournalArticle
  | ProofAssistantScript
  deriving (Eq, Show)

data Tradition = Tradition
  { traditionName :: String
  , period :: String
  , style :: ProofStyle
  , medium :: Medium
  , significance :: String
  } deriving (Eq, Show)

data HistoriographicWarning = HistoriographicWarning
  { warningTopic :: String
  , warningText :: String
  , mitigation :: String
  } deriving (Eq, Show)

traditions :: [Tradition]
traditions =
  [ Tradition "Mesopotamian scribal mathematics" "Ancient" Procedural Tablet
      "rule-based calculation and worked examples"
  , Tradition "Egyptian mathematical papyri" "Ancient" Procedural Papyrus
      "practical rules for arithmetic, area, and volume"
  , Tradition "Euclidean geometry" "Classical Greek" Deductive Diagram
      "axiomatic proposition-proof architecture"
  , Tradition "Chinese mathematical commentary" "Classical and medieval" Procedural Commentary
      "verification through procedure, configuration, and explanation"
  , Tradition "Islamic algebraic-geometric synthesis" "Medieval" Algebraic Commentary
      "translation, algebra, geometry, astronomy, and trigonometry"
  , Tradition "Nineteenth-century analysis" "Modern" Analytic PrintedBook
      "rigorization of limits, continuity, and real numbers"
  , Tradition "Foundations and mathematical logic" "Modern" FormalLogical JournalArticle
      "proof becomes an object of mathematical study"
  , Tradition "Proof assistants" "Contemporary" MachineChecked ProofAssistantScript
      "machine-checked formal proof artifacts"
  ]

warnings :: [HistoriographicWarning]
warnings =
  [ HistoriographicWarning "canon formation"
      "proof history can be reduced to a Greek-European story"
      "include multiple mathematical traditions and media"
  , HistoriographicWarning "presentism"
      "past practices can be judged only by modern formal standards"
      "interpret practices within their historical contexts"
  , HistoriographicWarning "machine proof"
      "machine-checked proof can be treated as the end of human proof"
      "recognize human choices in formalization and interpretation"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

traditionRows :: [String]
traditionRows =
  "name,period,proof_style,medium,significance,interpretation"
  : [ intercalate ","
        [ quote (traditionName item)
        , quote (period item)
        , show (style item)
        , show (medium item)
        , quote (significance item)
        , quote "typed proof-history metadata supports comparison without ranking"
        ]
    | item <- traditions
    ]

warningRows :: [String]
warningRows =
  "topic,warning,mitigation,interpretation"
  : [ intercalate ","
        [ quote (warningTopic item)
        , quote (warningText item)
        , quote (mitigation item)
        , quote "historiographic risk should be documented explicitly"
        ]
    | item <- warnings
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell proof-history scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_proof_traditions.csv" traditionRows
  writeLines "../outputs/tables/haskell_historiographic_warnings.csv" warningRows
  putStrLn "Done."
