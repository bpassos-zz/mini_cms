require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	asser @user.valid?
  end

  # Validating presence
  test "name should be present" do
  	@user.name = "	"
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email= " "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  # Testing for valid email addresses
  test "email validation should accept valid addresses" do
  	valid_address = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

  	valid_address.each do |valid_address|
  		@user.email = valid_address
  		# If test finds an error, output meaningful message
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  # Testing for invalid email addresses
  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar_baz.com]
  	
  	invalid_addresses.each do |invalid_addresses|
  		@user.email = invalid_addresses
  		assert_not @user.valid?, "#{invalid_addresses.inspect} should be invalid"
  	end
  end

  # Testing for uniqueness
  test "email address should be unique" do
  	duplicate_user = @user.dup

  	#tests for uppercase email addresses
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  # Testing for minimum password standards
  test "password should be present (nonblank)" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
end

