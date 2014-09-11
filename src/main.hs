import App.Input 
import App.Taxes

import System.Console.GetOpt
import System.Environment
import System.Exit

data Options = Options {
	  isVerbose :: Bool
	, isInteractive :: Bool
	, isHelp :: Bool
	} 
	deriving Show

defaults :: Options
defaults = Options {
	  isVerbose = False
	, isInteractive = False
	, isHelp = False
	}

options :: [ OptDescr (Options -> Options) ]
options = [
	  Option "i" ["interactive"] 
		(NoArg 
			(\opt -> opt { isInteractive = True }))
		"Take input through an interactive console session"
	, Option "v" ["verbose"]
		(NoArg 
			(\opt -> opt { isVerbose = True }))
		"Print every garbage into stdout"
	, Option "h" ["help"]
		(NoArg 
			(\opt -> opt { isHelp = True }))
		"Show this screen"
	]

printHelp :: IO ()
printHelp = do
	progName <- getProgName
	putStrLn (usageInfo progName options)

main = do
	args <- getArgs
	let (actions, nonOptions, errors) = getOpt RequireOrder options args
	let config = foldl (\v f -> f v) defaults actions
	if isHelp config
		then do
			printHelp
			exitWith ExitSuccess
		else if isInteractive config
			then interactiveSession
		else do
			printHelp
			exitWith (ExitFailure 1)

