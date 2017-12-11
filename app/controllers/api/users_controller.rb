# frozen_string_literal: true

class Api::UsersController < Api::BaseController
  def show
    render json: current_user
  end
end
