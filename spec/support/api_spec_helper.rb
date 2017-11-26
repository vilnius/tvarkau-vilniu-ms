module ApiSpecHelper

  delegate :token, to: :oauth_token

  def api_get(action, options = {})
    api_request(:get, action, options)
  end

  def api_post(action, options = {})
    api_request(:post, action, options)
  end

  def api_put(action, options = {})
    api_request(:put, action, options)
  end

  def api_delete(action, options = {})
    api_request(:delete, action, options)
  end

  def api_request(method, action, options)
    request.headers['Authorization'] ||= "Bearer #{token}"

    send(method, action, options)
  end

  def reset_response_json
    @response_json = nil
  end

  def response_json
    @response_json ||= JSON.parse(response.body)
  end

  def oauth_token
    @oauth_token ||= create(:oauth_token)
  end
end
