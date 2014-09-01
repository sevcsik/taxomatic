import App.Input 

main = do
	putStrLn "Type in incomes"
	incomes <- askList Income
	putStrLn $ "Entered incomes: " ++ (formatList incomes)
	expenses <- askList Expense
	putStrLn $ "Entered expenses: " ++ (formatList expenses)
