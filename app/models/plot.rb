class Plot < ApplicationRecord
  belongs_to :garden
  has_many :varieties
  has_many :plants, through: :varieties
end
