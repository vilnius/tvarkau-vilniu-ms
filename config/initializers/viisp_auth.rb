VIISP::Auth.configure do |c|
  c.test = true

  # TODO: configure before going live
  #
  # if Rails.env.production?
  #   c.pid = ENV['VIISP_PID']
  #   c.private_key = OpenSSL::PKey::RSA.new(Secret['VIISP_PRIVATE_KEY'])
  #   c.postback_url =
  # else
  #   c.test = true
  # end
end
