module App.Input (
	askList,
	formatList,
	InvoiceType(Income, Expense)
) where

import Control.Monad
import Control.Applicative
import Data.Maybe

data InvoiceType = Income | Expense deriving (Eq)

readFloat :: IO (Maybe Float)
readFloat = do
	value <- getLine
	if null value
		then return Nothing
		else return $ Just (read value :: Float)

ask :: InvoiceType -> IO (Maybe Float)
ask invoiceType = do
	if invoiceType == Income
		then putStrLn $ "Please type the total value of the next income"
		else putStrLn $ "Please type the total value of the next expense"
	readFloat

askList :: InvoiceType -> IO [Float]
askList invoiceType = do
	result <- ask invoiceType
	if result /= Nothing
		then (:) <$> (return (fromJust result)) <*> (askList invoiceType)
		else return []

formatList :: [Float] -> String
formatList [] = "<nothing>"
formatList (x:[]) = show x
formatList (x:xs) = (show x) ++ ", " ++ (formatList xs)
