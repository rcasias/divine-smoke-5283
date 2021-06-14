class Plant < ApplicationRecord
  has_many :varieties
  has_many :plots, through: :varieties
end
