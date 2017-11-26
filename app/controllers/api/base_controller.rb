class Api::BaseController < ApplicationController
  before_action -> { doorkeeper_authorize!(:user) }
  around_action :api

  VALIDATION_ERROR = 10

  protected

  def render_404(exception = nil, options = { render_items: false })
    #TODO: Implement logging
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

  def render_record_validation_error(record)
    render_api_error(
      VALIDATION_ERROR,
      :validation_error,
      errors: record.errors
    )
  end

  def render_api_error(code, error_message = null, errors = nil)
    hash = generate_api_message_hash(code, error_message, errors)

    render_api_response(hash, status: 400)
  end

  def generate_api_message_hash(code, error_message = nil, validation_errors = nil)
    hash = hash_for_code(code)

    hash[:message] = error_message unless error_message.nil?

    unless validation_errors.nil?
      hash[:errors] = validation_errors[:errors].messages.map do |field, message|
        {
          field: field.to_s,
          value: Array(message).join(', '),
        }
      end
    end

    hash
  end

  private

  def hash_for_code(code)
    {
      code: code,
    }
  end
end
