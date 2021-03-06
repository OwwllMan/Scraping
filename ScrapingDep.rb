require 'nokogiri'
require 'open-uri'

page = Nokogiri::XML(open("https://www.nosdeputes.fr/deputes/enmandat/xml"))#Récupère le xml

@namel = []#init les array 
@namef = []
@emails = []

def first_last(page)

  page.css("nom_de_famille").each do |y|#récupère chaque élément de la balise nom_de_famille
    y = y.text#le conv en texte
    @namel << y #et l'ajoute à l'array
    end

  page.css("prenom").each do |x|
    x = x.text
    @namef << x
  end
end

first_last(page)

def email(page)

  page.css("email[1]").each do |z|
    z = z.text
    @emails << z
  end
end

email(page)

final = @namel.zip(@namef, @emails)

for elem in final do 
  puts "#{elem}"
end
