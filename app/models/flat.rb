class Flat < ActiveRecord::Base
  attr_accessible :address, :bedroom_count, :latitude, :longitude, :name
  
  geocoded_by :address
  after_validation :geocode
end
