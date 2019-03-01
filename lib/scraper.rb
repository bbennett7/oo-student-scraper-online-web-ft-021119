require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    
    doc = Nokogiri::HTML(open(index_url))
    
    doc.css(".student-card").each do |student_card|
      student = Student.new({:name => "", :location => "", :profile_url => ""})
      student.name = student_card.css("h4").text
      student.location = student_card.css("p").text
      student.profile_url = student_card.css("a").first["href"]
      students_array << {:name => student.name, :location => student.location, :profile_url => student.profile_url}
    end
    students_array  
  end
  
  

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    site_hash = {}
    

  
    
    counter = 0
    
    doc.css(".social-icon-container").css("a").each do |site|
      first_name = doc.css(".vitals-text-container").css("h1").text.split[0]
      
      url = doc.css(".social-icon-container").css("a")[counter]["href"]
      
      if url.include?("twitter")
        site_hash[:twitter] = url 
      elsif url.include?("linkedin")
        site_hash[:linkedin] = url 
      elsif url.include?("github")
        site_hash[:github] = url 
      elsif url.include?("#{first_name}") #blog 
        site_hash[:blog] = url 
      end 
      binding.pry 
      counter += 1 
    end 
    
    if !doc.css(".bio-content").css("p").text.empty?
      site_hash[:bio] = doc.css(".bio-content").css("p").text
    end 
    
    if !doc.css(".profile-quote").text == nil 
      site_hash[:profile_quote] = doc.css(".profile-quote").text
    end 
    
    #:bio -->
    #:profile_quote --> doc.css(".profile-quote").text
    
    #:linkedin --> doc.css(".social-icon-container").css("a").first["href"]
    #:bio --> doc.css(".bio-content").css("p").text
    #:profile_quote --> 
    

    site_hash
  end

end

