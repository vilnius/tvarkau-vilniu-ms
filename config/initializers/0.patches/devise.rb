Devise::FailureApp.class_eval do
  protected

  # RAILS_RELATIVE_URL_ROOT default scope is already set in routes.rb
  def relative_url_root
    '/'
  end
end
