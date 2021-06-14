class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_plants_with_100_day_harvest
    self.plants.where('days_to_harvest < 100').distinct
  end
end
