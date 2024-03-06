class Plot < ApplicationRecord
  attr_accessor :new_planet_name

  belongs_to :user
  belongs_to :planet
  has_many :requests
end
