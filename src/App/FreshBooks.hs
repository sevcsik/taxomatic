module App.FreshBooks 
( freshBooksSession
) where

import App.Config

import Data.Maybe
import Control.Monad

freshBooksSession :: Config -> IO ()
freshBooksSession config = do
	let v = isVerbose config
	let domain = fromJust (getFreshBooksDomain config)
	let token = fromJust (getFreshBooksToken config)
	when v (putStrLn ("FreshBooks session: " ++ token ++ "@" ++ domain))

