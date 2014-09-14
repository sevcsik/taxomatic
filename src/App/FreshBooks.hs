module App.FreshBooks 
( freshBooksSession
) where

import App.Config

import Data.Maybe
import Control.Monad
import Network.HTTP.Conduit
import System.Exit

freshBooksSession :: Config -> IO ()
freshBooksSession config = do
	let v = isVerbose config
	let domain = fromJust (getFreshBooksDomain config)
	let token = fromJust (getFreshBooksToken config)
	when v $ putStrLn ("FreshBooks session: " ++ token ++ "@" ++ domain)
	requestAPI (buildURL domain token) "hello"v >>= putStrLn

buildURL :: String -> String -> String
buildURL domain token = 
	"https://" ++ domain ++ "/api/2.1/xml-in"

requestAPI :: String -> String -> Bool -> IO String
requestAPI url body v = do
	if isNothing $ parseUrl url
		then do
			putStrLn $ "Invalid URL: " ++ url
			exitWith (ExitFailure 2)
		else do
			when v $ putStrLn ("Using API endpoint: " ++ url)
			return "something"
	

