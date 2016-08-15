class Message
  def self.expired_endorsement_token
    "Expired token. Your recommendation has already been submitted"
  end

  def self.try_again
    "Something went wrong. Please try again"
  end

  def self.welcome
    "Welcome to Workdey!"
  end

  def self.choose_skill
    "Please choose at least one skill."
  end

  def self.update_success(obj)
    "#{obj} updated successfully."
  end
end
