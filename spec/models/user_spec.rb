require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(name:  "Anthony Kim", email:  "teSt@test.com", password:  "potato123", password_confirmation: "potato123")
  end

  describe 'Validations' do
    it "user should be created with all required fields" do
      @user.save
      expect(@user).to be_valid
    end

    it "should have email required" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should have name required" do
      @user.name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should have password required" do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should have password_confirmation required" do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should have a unique email, not case sensitive" do
      @user.save
      @newUser = User.new(:name => "Anthony Kim", :email => "TEST@test.coM", :password => "potato123", :password_confirmation => "potato123")
      @newUser.save
      expect(@newUser).to_not be_valid
      expect(@newUser.errors.full_messages).to include("Email has already been taken")

    end

    describe 'password' do
      it "should have minimum length of 5" do
        @user.password = "123"
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
    end

    describe '.authenticate_with_credentials' do

      it "should return a user when provided correct credentials" do
        @user.save
        authenticated_user = User.authenticate_with_credentials(@user.email, @user.password)
        expect(authenticated_user).to eq @user
      end

      it "should return NIL when provided incorrect credentials" do
        @user.save
        authenticated_user = User.authenticate_with_credentials(@user.email, "randompassword")
        expect(authenticated_user).to eq nil
      end

      it "should return a user when provided an email with white spaces around it " do
        @user.save
        authenticated_user = User.authenticate_with_credentials(" test@test.com ", @user.password)
        expect(authenticated_user).to eq @user  
      end

      it 'should return nil if there is no email matching in the database' do
        @user.save
        authenticated_user = User.authenticate_with_credentials('random@random.com', 'random')
        expect(authenticated_user).to eq nil
      end

      it 'should return a user when some letters from the email are uppercase' do
        @user.save
        authenticated_user = User.authenticate_with_credentials('teSt@tESt.COM', @user.password)
        expect(authenticated_user).to eq @user
      end

    end

  end
end
