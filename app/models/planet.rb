class Planet < ApplicationRecord
  has_many :plots
  has_many :users, through: :plots
  has_many :requests, through: :plots
end
