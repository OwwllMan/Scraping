require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"

def get_the_email_of_a_townhal_from_its_webpage(page)
  page = Nokogiri::HTML(open(page))
  text = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  if text != ""
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
    sleep(0.5)
  end
end

get_all_the_urls_of_val_doise_townhalls(PAGE_URL)
