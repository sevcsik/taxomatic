import App.Input 
import App.Taxes

import System.Console.GetOpt
import System.Environment
import System.Exit

data Options = Options {
	  isVerbose :: Bool
	, isInteractive :: Bool
	, isHelp :: Bool
	, getFreshBooksDomain :: Maybe String
	, getFreshBooksToken :: Maybe String
	} 
	deriving Show

defaults :: Options
defaults = Options {
	  isVerbose = False
	, isInteractive = False
	, isHelp = False
	, getFreshBooksDomain = Nothing
	, getFreshBooksToken = Nothing
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
		"Print every garbage to stdout"
	, Option "f" ["freshbooks-domain"]
		(ReqArg
			(\arg opt -> opt { getFreshBooksDomain = Just arg }) 
			"FBDOMAIN")
		"Download invoices from a given FreshBooks site"
	, Option "t" ["freshbooks-token"]
		(ReqArg
			(\arg opt -> opt { getFreshBooksToken = Just arg }) 
			"FBTOKEN")
		("Security token for the FreshBooks API - can be obtained at " ++
		"https://<your-site>.freshbooks.com/apiEnable")
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

