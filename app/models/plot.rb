class Plot < ApplicationRecord
  attr_accessor :new_planet_name

  belongs_to :user
  belongs_to :planet
  has_many :requests
  has_one_attached :photo
end
