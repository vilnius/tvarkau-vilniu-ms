class ApiAuthToken < ActiveRecord::Base

  def update_last_used
    return unless last_used > 5.minutes.ago

    self.last_used = Time.zone.now
    save(validate: false)
  end
end
