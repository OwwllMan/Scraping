require 'nokogiri'
require 'open-uri'




def  get_all_data

  @page = Nokogiri::HTML(open('https://www.nosdeputes.fr/deputes/enmandat/xml'))

  def first_name
    arrayFirstName = []
    fristName = @page.css('prenom')
    fristName.each do |prenom|
      if prenom == nil 
        prenom = ""
      end
      arrayFirstName << prenom.text
    end
    return arrayFirstName
  end

  def last_name
    arrayLastName = []
    lastName = @page.css('nom_de_famille')
    lastName.each do |nom|
      if nom == nil 
        nom = ""
      end
      arrayLastName << nom.text
    end
    return arrayLastName
  end

  def email
    arrayEmail = []
    email = @page.css('email[1]')
    email.each do |email|
      if email == nil 
        email = ""
      end
      arrayEmail << email.text
    end
    return arrayEmail
  end

  def firstName_lastName_email
    prenom_nom = Hash[first_name.zip(last_name)]
    prenom_nom_email = Hash[prenom_nom.zip(email)]
  end
  firstName_lastName_email
end

puts get_all_data

