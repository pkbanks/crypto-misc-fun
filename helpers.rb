require 'date'
require 'httparty'

# references:
# https://www.cryptocompare.com/api/#-api-data-price-

def getDateFromUnixDate(unixDate)
	# converts unixDate (String) and returns a friendly date (String)
	date = DateTime.strptime(unixDate, '%s')
	return date.strftime('%a, %b %d, %Y')
end

def coin_spot_price(fromSym, *toSyms)
	# fromSym: from symbol, as String
	# toSyms: to symbol, as multiple Strings
	# returns a hash / object literal, where each key (String)
	# returns a value that is equal to the number of fromSym per toSym

	# example, to go from US Dollars, to Bitcoin, Ethereum, and LiteCoint:
	# coin_spot_price('USD', 'BTC', 'ETH', 'LTC')
	
	endpoint = "https://min-api.cryptocompare.com/data/price?"
	url = endpoint + "fsym=" + fromSym + "&tsyms=" + toSyms.join(",")

	return HTTParty.get(url).parsed_response

end

def prices(base_currency, *coins)
	hash_response = coin_spot_price(base_currency, coins)
	result = {}
	hash_response.each do |coin, val|
		result[coin] = 1/val 
	end
	result
end