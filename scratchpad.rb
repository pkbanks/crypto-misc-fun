CORE_CURRENCIES = [{name: "US Dollar", symbol: "USD"}, {name: "Euro", symbol: "EUR"}, {name: "Japanese Yen", symbol: "JPY"}, {name: "British Pound", symbol: "GBP"}, {name: "Swiss Franc", symbol: "CHF"}, {name: "Canadian Dollar", symbol: "CAD"}, {name: "Australian Dollar", symbol: "AUD"}, {name: "New Zealand Dollar", symbol: "NZD"}, {name: "South African Rand", symbol: "ZAR"}, {name: "Chinese Yuan Renminbi", symbol: "CNY"}]
CORE_COINS = [{name: "bitcoin", symbol: 'BTC'}, {name: "bitcoin-cash", symbol: "BCH"}, {name: "ethereum", symbol:"ETH"}, {name: "ethereum-classic",symbol:"ETC"}, {name: "litecoin", symbol:"LTC"}, {name: "dash", symbol:"DASH"}, {name: "monero", symbol:"XMR"}, {name: "zcash", symbol:"ZEC"}, {name: "ripple", symbol:"XRP"}]

output = ""

CORE_CURRENCIES.each do |curr|
	puts "Currency.create(cur_name: '#{curr[:name]}', symbol: '#{curr[:symbol]}')"
end

CORE_COINS.each do |curr|
	puts "Currency.create(cur_name: '#{curr[:name]}', symbol: '#{curr[:symbol]}')"
end
