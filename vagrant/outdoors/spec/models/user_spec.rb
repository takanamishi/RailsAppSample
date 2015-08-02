require 'rails_helper'

RSpec.describe User, :type => :model do

  before do
    @user = User.new(email: "rspec@example.com", password: "abcd1234", password_confirmation: "abcd1234")
  end

  after do
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:salt) }
  it { should respond_to(:crypted_password) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "emailが入力されていない場合、@userの検証でエラーとなること" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "emailが既に登録されている場合、@userの検証でエラーとなること" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "passwordが入力されていない場合、@userの検証でエラーとなること" do
    before { 
      @user = User.new(email: "rspec@example.com", password: " ", password_confirmation: " ")
    }
    it { should_not be_valid }
  end

  describe "passwordが不一致の場合、@userの検証でエラーとなること" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "passwordが6文字未満の場合、@userの検証でエラーとなること" do
    before {
      @user.password = "a" * 5
      @user.password_confirmation = @user.password
    }
    it { should_not be_valid }
  end

  describe "passwordが24文字を超える場合、@userの検証でエラーとなること" do
    before {
      @user.password = "a" * 25
      @user.password_confirmation = @user.password
    }
    it { should_not be_valid }
  end

  describe "saveメソッドでDBにユーザーが登録されること" do
    before {
      @user.save
      @saved_user = User.find_by(email: @user.email)
    }

    it {
      expect(@saved_user.email).to eq @user.email
    }
  end

  describe "destoyメソッドでDBからユーザーが削除されること" do
    before {
      @user.save
      @user.destroy
      @destroy_user = User.find_by(email: @user.email)
    }

    it {
      expect(@destroy_user).to be_nil
    }
  end

end