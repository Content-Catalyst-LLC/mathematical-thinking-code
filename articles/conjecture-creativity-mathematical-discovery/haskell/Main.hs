{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Conjecture, Creativity, and Mathematical Discovery

module Main where

import Data.List (intercalate)

data ProofStatus
  = Observed
  | Conjectured
  | Refuted
  | Proved
  | ProvedUnderAssumptions
  deriving (Eq, Show)

data Evidence
  = Example String
  | FiniteCheck Int
  | Counterexample String
  | ProofSketch String
  | Simulation String
  deriving (Eq, Show)

data Conjecture = Conjecture
  { conjectureId :: String
  , statement :: String
  , domainDescription :: String
  , evidence :: [Evidence]
  , proofStatus :: ProofStatus
  } deriving (Eq, Show)

evenSquare :: Integer -> Bool
evenSquare n = odd n || even (n * n)

sumFirstN :: Integer -> Integer
sumFirstN n = sum [1..n]

sumFormula :: Integer -> Integer
sumFormula n = n * (n + 1) `div` 2

counterexamples :: [a] -> (a -> Bool) -> [a]
counterexamples xs predicate = [x | x <- xs, not (predicate x)]

finiteSumAudit :: [String]
finiteSumAudit =
  "n,computed_sum,formula_value,agrees,evidence_status"
  : [ intercalate ","
        [ show n
        , show (sumFirstN n)
        , show (sumFormula n)
        , show (sumFirstN n == sumFormula n)
        , "finite evidence only"
        ]
    | n <- [1..100]
    ]

conjectureRows :: [String]
conjectureRows =
  let conjectures =
        [ Conjecture
            "conj_even_square"
            "If n is even then n^2 is even."
            "integers"
            [FiniteCheck 100, ProofSketch "direct proof using n=2k"]
            Proved
        , Conjecture
            "conj_bounded_converges"
            "Every bounded sequence converges."
            "real sequences"
            [Example "constant sequence", Counterexample "(-1)^n"]
            Refuted
        ]
   in "conjecture_id,statement,domain,proof_status,evidence_count"
      : [ intercalate ","
            [ conjectureId c
            , quote (statement c)
            , quote (domainDescription c)
            , show (proofStatus c)
            , show (length (evidence c))
            ]
        | c <- conjectures
        ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell conjecture and discovery scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"

  writeLines "../outputs/tables/haskell_sum_finite_audit.csv" finiteSumAudit
  writeLines "../outputs/tables/haskell_conjecture_records.csv" conjectureRows
  writeLines "../outputs/tables/haskell_even_square_counterexamples.csv"
    ("n" : [show n | n <- counterexamples [-100..100] evenSquare])

  putStrLn "Done."
