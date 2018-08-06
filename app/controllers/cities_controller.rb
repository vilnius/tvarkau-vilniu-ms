# frozen_string_literal: true

class CitiesController < ApiController
  def index
    render json: City.active.all, root: :cities
  end
end
