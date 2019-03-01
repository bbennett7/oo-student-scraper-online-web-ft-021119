require 'nokogiri'
require 'open-uri'
require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self 
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      @@all << student 
    end 
  end

  def add_student_attributes(attributes_hash)
    
  end

  def name 
    @name 
  end 

  def self.all
    @@all 
  end
end

