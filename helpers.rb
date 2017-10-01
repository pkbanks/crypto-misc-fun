require 'date'
require 'httparty'
require 'nokogiri'
# references:
# https://www.cryptocompare.com/api/#-api-data-price-

# response = HTTParty.get("https://min-api.cryptocompare.com/data/histohour?fsym=ETH&tsym=USD&limit=60&aggregate=3&e=Kraken")

# currencies and coins we care about
core_currencies = ["USD", "EUR", "JPY", "GBP", "CHF", "CAD", "AUD", "NZD", "ZAR", "CNY"]
core_coins = ["bitcoin", "bitcoin-cash", "ethereum", "ethereum-classic", "litecoin", "dash", "monero", "zcash", "ripple"]

# puts response["Data"]

# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x[:time])
# end


# API returns the prices for every three days
# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x["time"].to_s)
# end
#
# puts response["Data"]


response = 
def getDateFromUnixDate(unixDate)
	# converts unixDate (String) and returns a friendly date (String)
	date = DateTime.strptime(unixDate, '%s')
	return date.strftime('%a, %b %d, %Y, %H:%M')
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



	# example: get prices history of bitcoin, ethereum, litecoin,
	# in USD, for last 100 days
	# 		price_hist("USD", 100, "BTC", "ETH", "LTC")

	endpoint = 'https://min-api.cryptocompare.com/data/histoday'
	url = endpoint + '?fsym=' + base_currency + '&tsym=' + coins.join(',') + '&limit=' + num_days
	response = HTTParty.get(url).parsed_response
	response
end

def price_hist_by_hour(from_currency="BTC", to_currency="USD", aggregate=1, num_hours=24*5)
	# from_currency = "BTC"
	# to_currency = "USD"
	# aggregate = 1		# hour frequency
	# num_hours = 24 * 5  # how many hours

	url = 'https://min-api.cryptocompare.com/data/histohour?fsym=' + from_currency + '&tsym=' + to_currency + '&limit=' + num_hours.to_s + '&aggregate=' + aggregate.to_s
	response = HTTParty.get(url).parsed_response
	return response
end

# p price_hist("USD", "BTC")
p price_hist_by_hour("ETH", "USD")

