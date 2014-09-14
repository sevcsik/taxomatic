module App.Config 
( Config (..)
) where

data Config = Config {
	  isVerbose :: Bool
	, isInteractive :: Bool
	, isHelp :: Bool
	, getFreshBooksDomain :: Maybe String
	, getFreshBooksToken :: Maybe String
	} 
	deriving Show
