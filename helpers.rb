require 'date'

def getDateFromUnixDate(unixDate)
	# converts unixDate (String) and returns a friendly date (String)
	date = DateTime.strptime(unixDate, '%s')
	return date.strftime('%a, %b %d, %Y')
end

def coint_spot_price(fromSym, toSyms)
	# fromSym: from symbol, as String
	# toSyms: to symbol, as multiple Strings

	# example, to go from US Dollars, to Bitcoin, Ethereum, and LiteCoint:
	# coin_spot_price('USD', 'BTC', 'ETH', 'LTC')
	# returns 
end

