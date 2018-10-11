require 'rubygems'
require 'nokogiri'
require 'open-uri'
url = "http://annuaire-des-mairies.com/val-d-oise.html"#url du site

def get_the_email_of_a_townhal_from_its_webpage(page)
  page = Nokogiri::HTML(open(page))
  text = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text #Récupère l'email et le format en string
  if text != ""#Si la section qui contient l'email est vide il va afficher "aucun email"
    return text
  else
    return "Aucun email"
  end
end

def get_all_the_urls_of_val_doise_townhalls(page)
  url = page.chomp("val-d-oise.html")
  page = Nokogiri::HTML(open(page))
  links = {}
  page.css("a.lientxt").each do |municipality|
    links[municipality.text] = get_the_email_of_a_townhal_from_its_webpage(url + municipality['href'].sub!("./", ""))
    puts "L'email de la mairie de #{municipality.text} est : #{links[municipality.text]}"
  end
end

get_all_the_urls_of_val_doise_townhalls(url)
