class Auth::ViispController < ActionController::Base
  include ActionView::Rendering

  def new
    postback_url = url_for(
      action: :create,
      redirect_uri: params[:redirect_uri],
    )

    @ticket = VIISP::Auth.ticket(postback_url: postback_url)

    render
  end

  def create
    if params[:redirect_uri].present?
      redirect_to(redirect_uri_with_ticket)
    else
      render plain: { ticket: params[:ticket] }.to_json, content_type: 'application/json'
    end
  end

  private

  def redirect_uri_with_ticket
    uri = URI.parse(params[:redirect_uri])

    query = URI.decode_www_form(uri.query || '')
    query << ['ticket', params[:ticket]]

    uri.query = URI.encode_www_form(query)
    uri.to_s
  end
end
