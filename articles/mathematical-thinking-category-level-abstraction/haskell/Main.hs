{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Mathematical Thinking and Category-Level Abstraction

module Main where

import Data.List (intercalate)

data CategoryDomain
  = Set
  | Group
  | Topology
  | VectorSpace
  | Poset
  | TypeSystem
  deriving (Eq, Show)

data MorphismKind
  = Function
  | Homomorphism
  | ContinuousMap
  | LinearMap
  | MonotoneMap
  | TypedFunction
  deriving (Eq, Show)

data CategoricalConcept
  = Object
  | Morphism
  | Functor
  | NaturalTransformation
  | UniversalProperty
  | Adjunction
  | YonedaPerspective
  deriving (Eq, Show)

data AbstractionRisk
  = PrematureAbstraction
  | Overgeneralization
  | DecorativeDiagram
  | JargonInflation
  | ComputationalNeglect
  | ForgottenStructure
  deriving (Eq, Show)

data CategoryRecord = CategoryRecord
  { domain :: CategoryDomain
  , morphismKind :: MorphismKind
  , preservedStructure :: String
  , compositionMeaning :: String
  , reviewQuestion :: String
  } deriving (Eq, Show)

data RiskRecord = RiskRecord
  { risk :: AbstractionRisk
  , problem :: String
  , mitigation :: String
  } deriving (Eq, Show)

records :: [CategoryRecord]
records =
  [ CategoryRecord Set Function
      "element assignment"
      "function composition"
      "Are we ignoring additional structure?"
  , CategoryRecord Group Homomorphism
      "group operation"
      "composition of homomorphisms"
      "Does the arrow preserve multiplication and identity?"
  , CategoryRecord Topology ContinuousMap
      "topological continuity"
      "composition of continuous maps"
      "Is the map continuous, not merely set-theoretic?"
  , CategoryRecord VectorSpace LinearMap
      "addition and scalar multiplication"
      "composition of linear transformations"
      "Does the transformation preserve linear combinations?"
  , CategoryRecord Poset MonotoneMap
      "order relation"
      "composition of monotone maps"
      "Does the map preserve order?"
  , CategoryRecord TypeSystem TypedFunction
      "computational typing and behavior"
      "typed function composition"
      "Does composition preserve types?"
  ]

risks :: [RiskRecord]
risks =
  [ RiskRecord PrematureAbstraction
      "categorical language appears before examples motivate it"
      "build from concrete categories and recurring patterns"
  , RiskRecord Overgeneralization
      "shared categorical form hides important domain differences"
      "ask what the functor preserves and what it forgets"
  , RiskRecord DecorativeDiagram
      "diagrams appear without proof-bearing content"
      "state commutativity and universal properties explicitly"
  , RiskRecord JargonInflation
      "terms replace understanding"
      "translate categorical language back into examples"
  , RiskRecord ComputationalNeglect
      "universal characterization hides algorithmic cost"
      "pair categorical structure with implementation analysis"
  , RiskRecord ForgottenStructure
      "a functor preserves one structure while forgetting another"
      "document preserved and forgotten features"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

recordRows :: [String]
recordRows =
  "domain,morphism_kind,preserved_structure,composition_meaning,review_question,interpretation"
  : [ intercalate ","
        [ show (domain item)
        , show (morphismKind item)
        , quote (preservedStructure item)
        , quote (compositionMeaning item)
        , quote (reviewQuestion item)
        , quote "chosen morphisms determine the visible structure of a category"
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
        , quote "category-level abstraction should remain grounded in examples and responsible interpretation"
        ]
    | item <- risks
    ]

workflowRows :: [String]
workflowRows =
  [ "stage,question,failure_mode"
  , "Objects,\"What entities or structures are being studied?\",\"unclear domain of discourse\""
  , "Arrows,\"What transformations are allowed?\",\"wrong or vague notion of relationship\""
  , "Structure,\"What do the arrows preserve or forget?\",\"important features are forgotten\""
  , "Universality,\"What role does the construction satisfy among all maps?\",\"construction understood only by recipe not role\""
  ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell category-level abstraction scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_category_records.csv" recordRows
  writeLines "../outputs/tables/haskell_abstraction_risks.csv" riskRows
  writeLines "../outputs/tables/haskell_objects_arrows_structure_universality.csv" workflowRows
  putStrLn "Done."
