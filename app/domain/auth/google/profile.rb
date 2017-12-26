module Auth::Google::Profile
  module_function

  def from_token(id_token)
    build(verify(id_token))
  end

  def verify(id_token)
    Auth::Google::VerifyToken.run(id_token, ENV['GOOGLE_APP_ID'])
  end

  def build(payload)
    return unless payload

    OpenStruct.new(
      id: payload['sub'],
      email: payload['email']&.downcase,
      given_name: payload['given_name'],
      family_name: payload['family_name'],
      picture: payload['picture'],
      locale: payload['locale'],
    )
  end
end
