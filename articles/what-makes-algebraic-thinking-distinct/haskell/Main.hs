{-# OPTIONS_GHC -Wall #-}

-- Haskell companion scaffold for:
-- What Makes Algebraic Thinking Distinct?

module Main where

import Data.List (intercalate)

data VariableRole
  = Unknown
  | GeneralizedNumber
  | FunctionInput
  | FunctionOutput
  | Parameter
  | Index
  | Coefficient
  deriving (Eq, Show)

data Expr
  = Var String
  | Const Double
  | Add Expr Expr
  | Mul Expr Expr
  | Pow Expr Int
  deriving (Eq, Show)

data Equation = Equation
  { equationId :: String
  , leftSide :: Expr
  , rightSide :: Expr
  , interpretation :: String
  } deriving (Eq, Show)

type Environment = [(String, Double)]

lookupVar :: String -> Environment -> Double
lookupVar name env =
  case lookup name env of
    Just value -> value
    Nothing -> error ("unbound variable: " ++ name)

eval :: Environment -> Expr -> Double
eval env expr =
  case expr of
    Var name -> lookupVar name env
    Const value -> value
    Add left right -> eval env left + eval env right
    Mul left right -> eval env left * eval env right
    Pow base exponent -> eval env base ^ exponent

render :: Expr -> String
render expr =
  case expr of
    Var name -> name
    Const value -> show value
    Add left right -> "(" ++ render left ++ " + " ++ render right ++ ")"
    Mul left right -> "(" ++ render left ++ " * " ++ render right ++ ")"
    Pow base exponent -> "(" ++ render base ++ "^" ++ show exponent ++ ")"

residual :: Environment -> Equation -> Double
residual env equation =
  eval env (leftSide equation) - eval env (rightSide equation)

quality :: Double -> String
quality value =
  if abs value < 1.0e-10 then "passes equation check" else "fails equation check"

quote :: String -> String
quote value = "\"" ++ concatMap escape value ++ "\""
  where
    escape '"' = "\"\""
    escape c = [c]

expressionRows :: [String]
expressionRows =
  let x = Var "x"
      factored = Mul (Const 2) (Add x (Const 3))
      expanded = Add (Mul (Const 2) x) (Const 6)
   in "x,factored_value,expanded_value,agrees,interpretation"
      : [ intercalate ","
            [ show n
            , show (eval [("x", fromIntegral n)] factored)
            , show (eval [("x", fromIntegral n)] expanded)
            , show (eval [("x", fromIntegral n)] factored == eval [("x", fromIntegral n)] expanded)
            , quote "sampled agreement supports but does not replace symbolic proof"
            ]
        | n <- [-10..10]
        ]

equationRows :: [String]
equationRows =
  let x = Var "x"
      equation = Equation "eq_linear" (Add (Mul (Const 3) x) (Const 2)) (Const 17) "linear equation as condition"
   in "candidate,residual,quality,interpretation"
      : [ intercalate ","
            [ show candidate
            , show (residual [("x", candidate)] equation)
            , quote (quality (residual [("x", candidate)] equation))
            , quote (interpretation equation)
            ]
        | candidate <- [4,5,6]
        ]

roleRows :: [String]
roleRows =
  "symbol,role,example"
  : [ "x,Unknown,x+3=10"
    , "n,GeneralizedNumber,n+n=2n"
    , "x,FunctionInput,f(x)=3x+2"
    , "m,Parameter,y=mx+b"
    , "n,Index,a_n=2n+1"
    ]

writeLines :: FilePath -> [String] -> IO ()
writeLines outputPath rows = writeFile outputPath (unlines rows)

main :: IO ()
main = do
  putStrLn "Haskell algebraic-thinking scaffold"
  putStrLn "Writing outputs into ../outputs/tables/"
  writeLines "../outputs/tables/haskell_equivalence_audit.csv" expressionRows
  writeLines "../outputs/tables/haskell_equation_residuals.csv" equationRows
  writeLines "../outputs/tables/haskell_variable_roles.csv" roleRows
  putStrLn "Done."
