import Control.Monad
import Control.Applicative
import Data.Maybe

import App.Input

readFloat :: IO (Maybe Float)
readFloat = do
	value <- getLine
	if null value
		then return Nothing
		else return $ Just (read value :: Float)

data InvoiceType = Income | Expense deriving (Eq)

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
formatList (x:[]) = show x
formatList (x:xs) = (show x) ++ ", " ++ (formatList xs)
	

main = do
	putStrLn "Type in incomes"
	incomes <- askList Income
	putStrLn $ "Entered incomes: " ++ (formatList incomes)
	expenses <- askList Expense
	putStrLn $ "Entered expenses " ++ (formatList expenses)
