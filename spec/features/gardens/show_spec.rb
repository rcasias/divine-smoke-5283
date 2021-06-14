require 'rails_helper'

RSpec.describe 'Garden Show' do
  describe 'Garden Show Story 3' do

    #     User Story 3, Garden's Plants
    # As a visitor
    # When I visit an garden's show page
    # Then I see a list of plants that are included in that garden's plots
    # And I see that this list is unique (no duplicate plants)
    # And I see that this list only includes plants that take less than 100 days to harvest

    it 'can visit page' do
      garden = Garden.create!(name: "Turing Community Garden", organic: true)
      visit "/gardens/#{garden.id}"
      expect(current_path).to  eq("/gardens/#{garden.id}")
    end

    it 'can list all plants in garden' do
      garden = Garden.create!(name: "Turing Community Garden", organic: true)

      plot_1 = garden.plots.create!(number: 25, size: "Large", direction: "East")
      plot_2 = garden.plots.create!(number: 15, size: "Large", direction: "West")
      plot_3 = garden.plots.create!(number: 10, size: "Large", direction: "East")
      plot_4 = garden.plots.create!(number: 30, size: "Large", direction: "North")

      plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_2 = Plant.create!(name: "Red Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 120)
      plant_3 = Plant.create!(name: "Green Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_4 = Plant.create!(name: "Orange Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_5 = Plant.create!(name: "Yellow Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 100)

      Variety.create!(plot: plot_1, plant: plant_1)
      Variety.create!(plot: plot_1, plant: plant_5)

      Variety.create!(plot: plot_2, plant: plant_1)
      Variety.create!(plot: plot_2, plant: plant_2)

      Variety.create!(plot: plot_3, plant: plant_3)
      Variety.create!(plot: plot_3, plant: plant_5)

      Variety.create!(plot: plot_4, plant: plant_4)
      Variety.create!(plot: plot_4, plant: plant_1)
      Variety.create!(plot: plot_4, plant: plant_2)
      Variety.create!(plot: plot_4, plant: plant_3)
      Variety.create!(plot: plot_4, plant: plant_5)


      visit "/gardens/#{garden.id}"
      expect(page).to  have_content(plant_1.name)
      expect(page).to_not  have_content(plant_2.name)
      expect(page).to  have_content(plant_4.name)
      expect(page).to  have_content(plant_3.name)
      expect(page).to_not  have_content(plant_5.name)

      expect(plant_1.name).to appear_before(plant_3.name)
    end
  end
end
