module App.Input (
	interactiveSession
) where

import App.Taxes

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

interactiveSession :: IO ()
interactiveSession = do
	putStrLn "Welcome to Tax-O-Matic\n"
	incomes <- askList Income
	expenses <- askList Expense
	let base = (sum incomes - sum expenses)
	putStrLn $ "List of incomes: " ++ (formatList incomes)
	putStrLn $ "List of expenses: " ++ (formatList expenses)
	putStrLn $ "Total income: " ++ (show (sum incomes))
	putStrLn $ "Total expense: " ++ (show (sum expenses))
	putStrLn $ "Profit: " ++ (show base)
	putStr $ "=== Tax Summary === \n" 
		++ (formatTaxes False (base))
	putStrLn $ "Net Profit: " ++ (show (base - (calculateTotalTaxes False base)))
