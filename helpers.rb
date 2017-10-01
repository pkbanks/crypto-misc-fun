require 'date'
require 'httparty'
require 'nokogiri'
# references:
# https://www.cryptocompare.com/api/#-api-data-price-

response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=60&aggregate=3&e=CCCAGG")

# puts response["Data"]

# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x[:time])
# end

#API returns the prices for every three days
# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x["time"].to_s)
# end
#
# puts response["Data"]

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
	# returns
	
	endpoint = "https://min-api.cryptocompare.com/data/price?"
	url = endpoint + "fsym=" + fromSym + "&tsyms=" + toSyms.join(",")

	return HTTParty.get(url).parsed_response

end

def prices(base_currency, *coins)
	# returns a hash of prices of coins per base_currency
	# for example, if we want to get prices of bitcoin,
	# ethereum, and litecoin in USD...
	# prices("USD", "BTC", "ETC", "LTC")

	hash_response = coin_spot_price(base_currency, coins)
	result = {}
	hash_response.each do |coin, val|
		result[coin] = 1/val 
	end
	result
end


def price_hist(base_currency, num_days=30, *coins)
	# example: get prices history of bitcoin, ethereum, litecoin,
	# in USD, for last 100 days
	# 		price_hist("USD", 100, "BTC", "ETH", "LTC")

	endpoint = 'https://min-api.cryptocompare.com/data/histoday'
	url = endpoint + '?fsym=' + base_currency + '&tsym=' + coins.join(',') + '&limit=' + num_days
	response = HTTParty.get(url).parsed_response
	response
end

p price_hist("USD", "BTC")