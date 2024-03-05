class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :plots
  has_many :requests
  has_many :requests_as_owner, through: :plots, source: :requests
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
