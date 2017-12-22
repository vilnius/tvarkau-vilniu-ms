class Auth::ViispController < ActionController::Base
  include ActionView::Rendering

  def new
    postback_url = url_for(
      action: :create,
      return_to_url: params[:return_to_url],
    )

    @ticket = VIISP::Auth.ticket(postback_url: postback_url)

    render
  end

  def create
    if params[:return_to_url].present?
      redirect_to(return_to_url_with_ticket)
    else
      render plain: { ticket: params[:ticket] }.to_json, content_type: 'application/json'
    end
  end

  private

  def return_to_url_with_ticket
    uri = URI.parse(params[:return_to_url])

    query = URI.decode_www_form(uri.query || '')
    query << ['ticket', params[:ticket]]

    uri.query = URI.encode_www_form(query)
    uri.to_s
  end
end
