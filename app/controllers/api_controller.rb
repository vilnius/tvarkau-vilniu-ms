class ApiController < ApplicationController
  before_action -> { doorkeeper_authorize! :public, :user }
  around_action :api

  VALIDATION_ERROR = 10

  protected

  def current_user
    return unless doorkeeper_token

    @current_user ||= fetch_user
  end

  def fetch_user
    return create_guest_user unless doorkeeper_token.resource_owner_id
    User.find_for_authentication(id: doorkeeper_token.resource_owner_id)
  end

  def create_guest_user
    user = Users::CreateGuest.run

    doorkeeper_token.update!(resource_owner_id: user.id)

    user
  end

  def current_city
    @current_city ||= city_from_header || current_user&.city ||
      raise('Request header X-City-ID not set and user has no default city')
  end

  def city_from_header
    return if request.headers['X-City-ID'].blank?
    City.find(request.headers['X-City-ID'])
  end

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
