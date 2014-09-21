module App.FreshBooks 
( freshBooksSession
) where

import App.Config

import Data.Maybe
import Control.Monad
import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Conduit
import Network.HTTP.Types.Method  
import System.Exit
import Data.ByteString.UTF8 as BS

freshBooksSession :: Config -> IO ()
freshBooksSession config = do
	let v = isVerbose config
	let domain = fromJust (getFreshBooksDomain config)
	let token = fromJust (getFreshBooksToken config)
	when v $ putStrLn ("FreshBooks session: " ++ token ++ "@" ++ domain)
	requestAPI (buildURL domain token) config >>= putStrLn

buildURL :: String -> String -> String
buildURL domain token = 
	"https://" ++ domain ++ "/api/2.1/xml-in"

buildRequest :: Request -> Request
buildRequest req = req {
	  method = renderStdMethod POST
	, secure = True
	, requestBody = RequestBodyBS (BS.fromString requestXML)
}

requestXML :: String
requestXML = "invalid xml"

requestAPI :: String -> Config -> IO String
requestAPI url config = do
	let v = isVerbose config
	case parseUrl url of
		Nothing -> do
			putStrLn $ "Invalid URL: " ++ url
			exitWith (ExitFailure 2)
		Just request -> withManager $ (\manager -> do
			liftIO $ do when v $ putStrLn ("Using API endpoint: " ++ url)
			response <- http (buildRequest request) manager
			liftIO $ do
				when v $ putStrLn ("Server response: " ++ 
					show (responseStatus response))
				return "body comes here"
			)

