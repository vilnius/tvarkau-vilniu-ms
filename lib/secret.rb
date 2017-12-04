module Secret
  module_function

  def [](name)
    return ENV[name] if ENV[name].present?

    secret_file = "/run/secrets/#{name.downcase}"

    File.read(secret_file) if File.exists?(secret_file)
  end
end
