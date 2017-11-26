# frozen_string_literal: true

module Auth::Google::Certs
  URI = 'https://www.googleapis.com/oauth2/v1/certs'
  CACHE_KEY = 'google.certs'
  CACHE_OPTIONS = {
    expires_in: 1.day,
  }.freeze

  module_function

  def all
    certs = {}

    cached_certs.each do |key, cert|
      certs[key] = OpenSSL::X509::Certificate.new(cert)
    end

    certs
  end

  def cached_certs
    Rails.cache.fetch(CACHE_KEY, CACHE_OPTIONS) { download_certs }
  end

  def download_certs
    body = Faraday.get(URI).body
    JSON.parse(body)
  end
end
