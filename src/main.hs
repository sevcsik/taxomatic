import Control.Monad

inputIncome :: Int -> IO (Maybe Float)

inputIncome index = do
	putStrLn $ "Please type the total value of income #" ++ show index
	value <- getLine
	if null value
		then return Nothing
		else return $ Just (read value :: Float)

main = do
	result <- inputIncome 1
	print result
		
		
	
