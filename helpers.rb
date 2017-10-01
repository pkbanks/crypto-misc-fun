require 'date'

require 'nokogiri'
require 'HTTParty'

response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=60&aggregate=3&e=CCCAGG")

# puts response["Data"]

# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x[:time])
# end


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

#API returns the prices for every three days
# response["Data"].each do |x|
# 	puts getDateFromUnixDate(x["time"].to_s)
# end
#
# puts response["Data"]
