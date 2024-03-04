class User < ApplicationRecord
  has_many :plots
  has_many :requests
  has_many :planets, through: :plots
end
