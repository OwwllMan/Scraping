require 'nokogiri'
require 'open-uri'
require 'awesome_print'


def  get_all_crypto_price(url)

	@page = Nokogiri::HTML(open(url))

	def cryptoPrice 
		@arrayOfPrice = []
		@page.css("a.price").each do |price|
			@arrayOfPrice << price.text
		end
		return @arrayOfPrice
	end


	def cryptoName
		@arrayOfName = []
		@page.css("a.currency-name-container").each do |name|
			@arrayOfName << name.text
		end
		return @arrayOfName
	end

	def final 
		cryptoHash = Hash[cryptoName.zip(cryptoPrice)]
		for crypto in cryptoHash.keys
			puts "Le cours de la cryptomonnaie #{crypto} est à :#{cryptoHash[crypto]}.red" 
		end
	end
	final
end

@count = 0
while 1
	if @count == 0
		get_all_crypto_price("https://coinmarketcap.com/all/views/all/")
		@count += 3600
	end
	print "Actualisation dans : #{Time.at(@count).utc.strftime("%H:%M:%S").red}   #{"[CTRL-C pour quitter]".greenish}\r"
	sleep(1)
	@count -= 1
end




