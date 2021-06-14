class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  # def unique_plants_with_100_day_harvest
  #   self.plants.where('days_to_harvest < 100').distinct
  # end

  def unique_plants_with_100_day_harvest_sorted
    self.plants.select('plants.name', 'count(plants.name) as total_num_plant')
        .where('days_to_harvest < 100')
        .group('plants.name').distinct
        .order('total_num_plant DESC')
  end
end
