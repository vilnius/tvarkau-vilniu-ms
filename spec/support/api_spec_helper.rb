module ApiSpecHelper

  delegate :token, to: :api_auth_token

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
    reset_response_json

    options[:params] ||= {}
    options[:params].reverse_merge!(token: token)

    send(method, action, options)
  end

  def reset_response_json
    @response_json = nil
  end

  def response_json
    @response_json ||= JSON.parse(response.body)
  end

  def api_auth_token
    @api_auth_token ||= create(:api_auth_token)
  end
end
