import App.Input 
import App.Taxes

main = do
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

