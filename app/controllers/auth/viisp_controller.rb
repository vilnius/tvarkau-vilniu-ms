class Auth::ViispController < ActionController::Base
  include ActionView::Rendering

  ALLOWED_REDIRECT_URIS = ENV['VIISP_REDIRECT_URIS'].to_s.split(',').freeze

  before_action :check_redirect_uri

  def new
    postback_url = url_for(
      action: :create,
      redirect_uri: redirect_uri,
    )

    @ticket = VIISP::Auth.ticket(postback_url: postback_url)

    render
  end

  def create
    if redirect_uri.present?
      redirect_to(redirect_uri_with_ticket)
    else
      render plain: { ticket: params[:ticket] }.to_json, content_type: 'application/json'
    end
  end

  private

  def redirect_uri_with_ticket
    uri = URI.parse(redirect_uri)

    query = URI.decode_www_form(uri.query || '')
    query << ['ticket', params[:ticket]]

    uri.query = URI.encode_www_form(query)
    uri.to_s
  end

  def check_redirect_uri
    return if redirect_uri.blank?
    return if redirect_uri.in?(ALLOWED_REDIRECT_URIS)

    error = "VIISP redirect uri #{redirect_uri} is not allowed"

    Rails.logger.error(error)

    render plain: error, status: :forbidden
  end

  def redirect_uri
    params[:redirect_uri]
  end
end
