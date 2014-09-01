import App.Input 

main = do
	putStrLn "Type in incomes"
	incomes <- askList Income
	putStrLn $ "Entered incomes: " ++ (formatList incomes)
	expenses <- askList Expense
	putStrLn $ "Entered expenses: " ++ (formatList expenses)
	putStrLn $ "Total income: " ++ (show (sum incomes))
	putStrLn $ "Total expense: " ++ (show (sum expenses))
	putStrLn $ "Profit: " ++ (show (sum incomes - sum expenses))
	
