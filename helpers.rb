require 'date'
require 'httparty'
require 'nokogiri'
# references:
# https://www.cryptocompare.com/api/#-api-data-price-

# currencies and coins we care about
core_currencies = ["USD", "EUR", "JPY", "GBP", "CHF", "CAD", "AUD", "NZD", "ZAR", "CNY"]
core_coins = ["bitcoin", "bitcoin-cash", "ethereum", "ethereum-classic", "litecoin", "dash", "monero", "zcash", "ripple"]

def getDateFromUnixDate(unixDate, format = '%H:%M %a %d %b %Y')
	# converts unixDate (String) and returns a friendly date (String)
	date = DateTime.strptime(unixDate, '%s')
	return date.strftime(format)
end

def coin_spot_price(fromSym, *toSyms)
	# fromSym: symbol of coin or currency, as String
	# toSyms: to symbol, as multiple Strings
	# returns a hash / object literal, where each key (String)
	# returns a value that is equal to the number of fromSym per toSym

	# example, to get how much Bitcoin, Ethereum, Litecoin
	# we can buy with 1 USD:
	# result = coin_spot_price('USD', 'BTC', 'ETH', 'LTC')
	# p result["BTC"]  # <-- how many BTC per dollar

	# to find out prices for 1 BTC in USD, JPY, CAD, CHF...
	# coin_spot_price("BTC", "USD", "CAD", "CHF", "JPY")

	# to get how many USD per BTC, use the prices method
	
	endpoint = "https://min-api.cryptocompare.com/data/price?"
	url = endpoint + "fsym=" + fromSym.upcase + "&tsyms=" + toSyms.map{|coin| coin.upcase}.join(",")
	return HTTParty.get(url).parsed_response

end

def prices(base_currency, *coins)
	# returns a hash of prices in base_currency for each of the coins OR currency
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
	# example: get price history of bitcoin, ethereum, litecoin,
	# in USD, for last 100 days
	# 		price_hist("USD", 100, "BTC", "ETH", "LTC")

	endpoint = 'https://min-api.cryptocompare.com/data/histoday'
	url = endpoint + '?fsym=' + base_currency.upcase + '&tsym=' + coins.map{|coin| coin.upcase}.join(',') + '&limit=' + num_days.to_s
	response = HTTParty.get(url).parsed_response
	response
end

def price_hist_by_hour(from_currency="BTC", to_currency="USD", aggregate=1, num_hours=24*5)
	# from_currency = "BTC"
	# to_currency = "USD"
	# aggregate = 1		# hour frequency
	# num_hours = 24 * 5  # how many hours

	url = 'https://min-api.cryptocompare.com/data/histohour?fsym=' + from_currency.upcase + '&tsym=' + to_currency.upcase + '&limit=' + num_hours.to_s + '&aggregate=' + aggregate.to_s
	response = HTTParty.get(url).parsed_response
	return response
end

def tests
	# get btc in currencies
	currencies = ['usd', 'jpy', 'chf']
	response = coin_spot_price('btc', currencies.join(','))
	puts "BTC, spot"
	currencies.each do |c|
		puts "#{c}\t #{response[c.upcase]}"
	end


end

tests