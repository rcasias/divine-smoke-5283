require 'rails_helper'

RSpec.describe Garden do

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  it 'should list unique plants that take 100 or less day to harvest' do
    garden = Garden.create!(name: "Turing Community Garden", organic: true)

    plot_1 = garden.plots.create!(number: 25, size: "Large", direction: "East")
    plot_2 = garden.plots.create!(number: 15, size: "Large", direction: "West")
    plot_3 = garden.plots.create!(number: 10, size: "Large", direction: "East")
    plot_4 = garden.plots.create!(number: 30, size: "Large", direction: "North")

    plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    plant_2 = Plant.create!(name: "Red Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 120)
    plant_3 = Plant.create!(name: "Green Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    plant_4 = Plant.create!(name: "Orange Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)

    Variety.create!(plot: plot_1, plant: plant_1)
    Variety.create!(plot: plot_2, plant: plant_2)
    Variety.create!(plot: plot_3, plant: plant_3)

    Variety.create!(plot: plot_4, plant: plant_4)
    Variety.create!(plot: plot_4, plant: plant_1)
    Variety.create!(plot: plot_4, plant: plant_2)
    Variety.create!(plot: plot_4, plant: plant_3)
    # binding.pry

    expect(garden.unique_plants_with_100_day_harvest).to eq([plant_1, plant_3, plant_4])
  end
end
