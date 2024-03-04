class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :plots
  has_many :requests
  has_many :planets, through: :plots
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
