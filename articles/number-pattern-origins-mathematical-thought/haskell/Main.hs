{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Number, Pattern, and the Origins of Mathematical Thought

module Main where

import Data.List (intercalate)

data Unit
  = Stone String
  | Grain String
  | Step String
  | Mark
  deriving (Eq, Show)

data ProofStatus
  = Observed
  | Conjectured
  | FiniteEvidence
  | Refuted
  | Proved
  deriving (Eq, Show)

data Pattern
  = TallyPattern [Unit]
  | SequencePattern String [Integer] ProofStatus
  | CyclePattern String Integer [Integer] ProofStatus
  deriving (Eq, Show)

tally :: [Unit] -> [Unit]
tally units =
  [Mark | _ <- units]

differences :: [Integer] -> [Integer]
differences xs =
  zipWith (-) (tail xs) xs

secondDifferences :: [Integer] -> [Integer]
secondDifferences =
  differences . differences

isArithmetic :: [Integer] -> Bool
isArithmetic xs =
  case differences xs of
    [] -> False
    ds -> all (== head ds) ds

isQuadraticByFiniteDifference :: [Integer] -> Bool
isQuadraticByFiniteDifference xs =
  case secondDifferences xs of
    [] -> False
    ds -> all (== head ds) ds

cycleValues :: Integer -> Integer -> [Integer]
cycleValues period count =
  [n `mod` period | n <- [0..(count - 1)]]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

sequenceRows :: [String]
sequenceRows =
  let examples =
        [ ("even", [2,4,6,8,10,12])
        , ("triangular", [1,3,6,10,15,21])
        , ("squares", [1,4,9,16,25,36])
        ]
   in "sequence_id,values,first_differences,second_differences,is_arithmetic,is_quadratic,interpretation"
      : [ intercalate ","
            [ name
            , quote (unwords (map show values))
            , quote (unwords (map show (differences values)))
            , quote (unwords (map show (secondDifferences values)))
            , show (isArithmetic values)
            , show (isQuadraticByFiniteDifference values)
            , quote "finite differences suggest pattern; proof establishes generality"
            ]
        | (name, values) <- examples
        ]

tallyRows :: [String]
tallyRows =
  let stones = [Stone "a", Stone "b", Stone "c", Stone "d"]
      marks = tally stones
   in "object_count,mark_count,correspondence_note"
      : [intercalate "," [show (length stones), show (length marks), quote "one object corresponds to one mark"]]

cycleRows :: [String]
cycleRows =
  "index,value,period,formula_note"
  : [ intercalate "," [show i, show (i `mod` 4), "4", "n mod 4"]
    | i <- [0..15 :: Integer]
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell number-pattern origins scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_sequence_audit.csv" sequenceRows
  writeLines "../outputs/tables/haskell_tally_audit.csv" tallyRows
  writeLines "../outputs/tables/haskell_cycle_pattern.csv" cycleRows
  putStrLn "Done."
