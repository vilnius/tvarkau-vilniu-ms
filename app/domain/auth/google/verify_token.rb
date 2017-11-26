# frozen_string_literal: true

class Auth::Google::VerifyToken
  include Interactor::Initializer

  initialize_with :token, :aud

  def run
    payload = nil

    certs.find { |cert| payload = decode(token, cert) }

    return unless payload
    return unless payload['aud'] == aud

    payload
  end

  private

  def certs
    @certs ||= Auth::Google::Certs.all.values
  end

  def decode(token, cert)
    payload, = JWT.decode(token, cert.public_key, true)
    payload
  rescue JWT::DecodeError
    # ignore, continue to next cert
  end
end
