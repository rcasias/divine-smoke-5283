class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @gardens_plants = @garden.unique_plants_with_100_day_harvest_sorted
  end

end
