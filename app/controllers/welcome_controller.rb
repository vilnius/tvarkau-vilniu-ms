class WelcomeController < ApplicationController
  def index
    render json: { message: 'Welcome!' }
  end
end
