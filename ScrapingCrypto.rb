require 'nokogiri'
require 'open-uri'
require 'awesome_print'


def  get_all_crypto_price(url)

	@page = Nokogiri::HTML(open(url))

	def cryptoPrice 
		@arrayOfPrice = []#Initialise l'array 
		@page.css("a.price").each do |price|#target les balises a avec la classe price 
			@arrayOfPrice << price.text#Ajoute chaque prix dans l'array
		end
		return @arrayOfPrice#Attribu les valeurs de l'array à la méthode 
	end

	def cryptoName
		@arrayOfName = []
		@page.css("a.currency-name-container").each do |name|
			@arrayOfName << name.text
		end
		return @arrayOfName
	end

	def final 
		cryptoHash = Hash[cryptoName.zip(cryptoPrice)]#Zip les deux array en un hash la key sera Le nom et la value la valeur 
		for crypto in cryptoHash.keys
			puts "Le cours de la cryptomonnaie #{crypto} est à :#{cryptoHash[crypto]}" 
		end
	end
	final
end

@count = 0#Count init à 0 pour afficher une première fois le hash
while 1#Condition toujours vraie 
	if @count == 0
		get_all_crypto_price("https://coinmarketcap.com/all/views/all/")#Affiche le tout 
		@count += 3600#Puis count va être init à 1h 
	end
	print "Actualisation dans : #{Time.at(@count).utc.strftime("%H:%M:%S").red}   #{"[CTRL-C pour quitter]".greenish}\r"
	sleep(1)#Attend 1 sec 
	@count -= 1#Décrémente chaque seconde
end




