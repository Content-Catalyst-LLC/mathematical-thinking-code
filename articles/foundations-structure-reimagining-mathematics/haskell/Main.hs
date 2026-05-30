{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- Foundations, Structure, and the Reimagining of Mathematics

module Main where

import Data.List (intercalate)

data FoundationView
  = SetTheoretic
  | Logical
  | Formalist
  | Intuitionistic
  | Structural
  | Computational
  deriving (Eq, Show)

data Structure
  = Group
  | VectorSpace
  | TopologicalSpace
  | Graph
  | Category
  | FormalSystem
  deriving (Eq, Show)

data PreservationMap
  = Homomorphism
  | LinearMap
  | ContinuousMap
  | GraphMorphism
  | Functor
  | FormalTranslation
  deriving (Eq, Show)

data FormalLayer
  = Concept
  | Definition
  | Theorem
  | Proof
  | Interpretation
  deriving (Eq, Show)

data StructureRecord = StructureRecord
  { structureName :: Structure
  , objects :: String
  , operations :: String
  , preservedBy :: PreservationMap
  , note :: String
  } deriving (Eq, Show)

data FoundationRecord = FoundationRecord
  { foundation :: FoundationView
  , question :: String
  , strength :: String
  , limitation :: String
  } deriving (Eq, Show)

data AbstractionWarning = AbstractionWarning
  { topic :: String
  , warning :: String
  , mitigation :: String
  } deriving (Eq, Show)

preserves :: Structure -> PreservationMap
preserves structure =
  case structure of
    Group -> Homomorphism
    VectorSpace -> LinearMap
    TopologicalSpace -> ContinuousMap
    Graph -> GraphMorphism
    Category -> Functor
    FormalSystem -> FormalTranslation

structureRecords :: [StructureRecord]
structureRecords =
  [ StructureRecord Group "elements such as symmetries, transformations, or numbers"
      "one associative operation with identity and inverses" Homomorphism
      "structure is defined by operation laws"
  , StructureRecord VectorSpace "vectors, functions, signals, or data points"
      "addition and scalar multiplication" LinearMap
      "linear structure appears across mathematics and data"
  , StructureRecord TopologicalSpace "points and open sets"
      "openness, continuity, nearness, deformation" ContinuousMap
      "qualitative structure rather than exact measurement"
  , StructureRecord Graph "vertices and edges"
      "adjacency, incidence, paths, connectivity" GraphMorphism
      "edge meaning depends on context"
  , StructureRecord Category "objects and morphisms"
      "composition and identity morphisms" Functor
      "category-level thinking centers transformations"
  , StructureRecord FormalSystem "symbols, formulas, axioms, proofs"
      "inference rules and derivability" FormalTranslation
      "proof becomes an object of study"
  ]

foundationRecords :: [FoundationRecord]
foundationRecords =
  [ FoundationRecord SetTheoretic
      "Can mathematics be built from sets and membership?"
      "broad common language"
      "membership language may not reflect everyday mathematical practice"
  , FoundationRecord Formalist
      "Can mathematics be secured through formal systems?"
      "makes syntax and rules explicit"
      "syntax can be mistaken for meaning"
  , FoundationRecord Structural
      "What relations and operations define mathematical objects?"
      "reveals sameness beneath different representations"
      "abstraction can detach from examples and access"
  , FoundationRecord Computational
      "What can be computed, checked, simulated, or verified?"
      "makes procedures executable and proofs checkable"
      "computation can be mistaken for proof or wisdom"
  ]

warnings :: [AbstractionWarning]
warnings =
  [ AbstractionWarning "modeling"
      "formal clarity can conceal modeling choices"
      "state assumptions, domains, constraints, and omissions"
  , AbstractionWarning "optimization"
      "a mathematically solved system can optimize the wrong objective"
      "interrogate objectives before solving"
  , AbstractionWarning "proof and verification"
      "proof or verification can be mistaken for full adequacy"
      "distinguish specification, proof, interpretation, and consequence"
  ]

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

structureRows :: [String]
structureRows =
  "structure,objects,operations,preserved_by,note,interpretation"
  : [ intercalate ","
        [ show (structureName item)
        , quote (objects item)
        , quote (operations item)
        , show (preservedBy item)
        , quote (note item)
        , quote "typed structures make preservation maps explicit"
        ]
    | item <- structureRecords
    ]

foundationRows :: [String]
foundationRows =
  "foundation_view,central_question,strength,limitation,interpretation"
  : [ intercalate ","
        [ show (foundation item)
        , quote (question item)
        , quote (strength item)
        , quote (limitation item)
        , quote "foundation views clarify different aspects of mathematical practice"
        ]
    | item <- foundationRecords
    ]

warningRows :: [String]
warningRows =
  "topic,warning,mitigation,interpretation"
  : [ intercalate ","
        [ quote (topic item)
        , quote (warning item)
        , quote (mitigation item)
        , quote "responsible abstraction requires review beyond formal correctness"
        ]
    | item <- warnings
    ]

layerRows :: [String]
layerRows =
  "layer,human_responsibility,interpretation"
  : [ intercalate ","
        [ show layer
        , quote "human choice remains central even when formal checking is automated"
        , quote "proof assistants verify derivations but do not choose meanings or purposes"
        ]
    | layer <- [Concept, Definition, Theorem, Proof, Interpretation]
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell foundations and structure scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_structure_records.csv" structureRows
  writeLines "../outputs/tables/haskell_foundation_views.csv" foundationRows
  writeLines "../outputs/tables/haskell_abstraction_warnings.csv" warningRows
  writeLines "../outputs/tables/haskell_formal_layers.csv" layerRows
  putStrLn "Done."
