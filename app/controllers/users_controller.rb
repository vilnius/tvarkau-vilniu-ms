# frozen_string_literal: true

class UsersController < ApiController
  def show
    render json: current_user
  end
end
