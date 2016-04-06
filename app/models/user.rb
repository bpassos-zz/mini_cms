class User < ActiveRecord::Base
  attr_accessor :remember_token

  # This uses the before_save callback to normalize all email addresses to lowercase.
  before_save { self.email = email.downcase }
  validates :name,  
            presence: true, 
            length: { maximum: 50 }

  # This is a constant, indicated in Ruby by a name starting with capital leter
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
            presence: true, 
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },

            # This also assumes uniqueness returnes true
            uniqueness: { case_sensitive: false }

  # The password needs to be Hashed. When authenticating users, we need to hash the password and compare to the hash value on the database.
  # This method adds the following functionality:
    # The ability to sabe a secure hashed password_digest attribute to the database.
    # A pair of virtual attributes (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match.
    # An authenticate mathod that returns the user when the password is correct (and false otherwise).
  # The only requirement for this method to work is to have a password_digest attribute in the corresponding model.
  has_secure_password

  validates :password, 
            presence: true,
            length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
