class Plot < ApplicationRecord
  belongs_to :user
  belongs_to :planet
  has_many :requests
end
