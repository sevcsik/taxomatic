module App.Taxes (
	calculateTaxes
) where

rates = 
	[("Szemelyi jovedelemado", 16)
	,("Nyugdijjarulek", 10)
	,("Egeszsegbiztositasi jarulek", 8.5)
	]

fullTimeRates = 
	[("Munkaeropiaci jarulek", 1.5)
    ]

applyRate :: Float -> (String, Float) -> (String, Float)
applyRate base (name, rate) = (name, base * (rate / 100))

calculateTaxes :: Bool -> Float -> [(String, Float)]
calculateTaxes False base = map (applyRate base) rates 
calculateTaxes True base = map (applyRate base) (rates ++ fullTimeRates) 


