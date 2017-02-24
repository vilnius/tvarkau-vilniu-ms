class Api::BaseController < ApplicationController
  before_action :adjust_request_format
  around_action :api

protected

  def render_404(exception = nil, options = { render_items: false })
    #TODO implement logging
    render_api_response({}, status: 404)
  end

  def default_render(*)
  end

  def api
    result = yield
    render_api_response(result) unless performed?
  end

  def render_api_response(hash = {}, options = {})
    status = options[:status] || 200
    render(json: hash, status: status)
  end

  def adjust_request_format
    request.format = :json if request.format == :html
  end
end