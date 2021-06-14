require 'rails_helper'

RSpec.describe 'Plot Index' do
  describe 'Plot Index Story 1' do

    #     User Story 1, Plots Index Page
    # As a visitor
    # When I visit the plots index page ('/plots')
    # I see a list of all plot numbers
    # And under each plot number I see names of all that plot's plants
    it 'can visit page' do
      visit '/plots'
      expect(current_path).to  eq('/plots')
    end

    it 'lists plot numbers' do
      garden = Garden.create!(name: "Turing Community Garden", organic: true)

      plot_1 = garden.plots.create!(number: 25, size: "Large", direction: "East")
      plot_2 = garden.plots.create!(number: 15, size: "Large", direction: "West")
      plot_3 = garden.plots.create!(number: 10, size: "Large", direction: "East")
      plot_4 = garden.plots.create!(number: 30, size: "Large", direction: "North")

      visit '/plots'

      expect(page).to have_content(plot_1.number)
      expect(page).to have_content(plot_2.number)
      expect(page).to have_content(plot_3.number)
      expect(page).to have_content(plot_4.number)
    end

    it 'lists plants in each plot' do
      garden = Garden.create!(name: "Turing Community Garden", organic: true)

      plot_1 = garden.plots.create!(number: 25, size: "Large", direction: "East")
      plot_2 = garden.plots.create!(number: 15, size: "Large", direction: "West")
      plot_3 = garden.plots.create!(number: 10, size: "Large", direction: "East")
      plot_4 = garden.plots.create!(number: 30, size: "Large", direction: "North")

      plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_2 = Plant.create!(name: "Red Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_3 = Plant.create!(name: "Green Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      plant_4 = Plant.create!(name: "Orange Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)

      Variety.create!(plot: plot_1, plant: plant_1)
      Variety.create!(plot: plot_2, plant: plant_2)
      Variety.create!(plot: plot_3, plant: plant_3)
      Variety.create!(plot: plot_4, plant: plant_4)


      visit '/plots'
      expect(page).to have_content(plant_1.name)
      expect(page).to have_content(plant_2.name)
      expect(page).to have_content(plant_3.name)
      expect(page).to have_content(plant_4.name)
    end

      #     User Story 2, Remove a Plant from a Plot
      # As a visitor
      # When I visit a plot's index page
      # Next to each plant's name
      # I see a link to remove that plant from that plot
      # When I click on that link
      # I'm returned to the plots index page
      # And I no longer see that plant listed under that plot
      # (Note: you should not destroy the plant record entirely)

      it 'can remove plant from plot' do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)

        plot_1 = garden.plots.create!(number: 25, size: "Large", direction: "East")

        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Red Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_3 = Plant.create!(name: "Green Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_4 = Plant.create!(name: "Orange Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)

        Variety.create!(plot: plot_1, plant: plant_1)
        Variety.create!(plot: plot_1, plant: plant_2)
        Variety.create!(plot: plot_1, plant: plant_3)
        Variety.create!(plot: plot_1, plant: plant_4)


        visit '/plots'
        expect(page).to have_button("Remove Plant #{plant_1.name} from Plot")
        click_button("Remove Plant #{plant_1.name} from Plot")
        expect(current_path).to eq('/plots')
        expect(page).to_not have_content(plant_1.name)
        expect(page).to have_content(plant_2.name)
        expect(page).to have_content(plant_3.name)
        expect(page).to have_content(plant_4.name)
        save_and_open_page
      end



  end
end
