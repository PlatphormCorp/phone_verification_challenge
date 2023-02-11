require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'model' do
    it "is invalid if email is blank" do
      user = User.new(email: nil, password: 'password', password_confirmation: 'password')
      expect(user.valid?).to equal(false)
    end
    it "is invalid if password is blank" do
      user = User.new(email: 'test@example.com', password: nil, password_confirmation: 'password')
      expect(user.valid?).to equal(false)
    end
    it "is invalid if password AND password confirmation is blank" do
      user = User.new(email: 'test@example.com', password: nil, password_confirmation: nil)
      expect(user.valid?).to equal(false)
    end
    it "is invalid if password confirmation does not match password" do
      user = User.new(email: 'test@example.com', password: 'passw0rd', password_confirmation: 'password')
      expect(user.valid?).to equal(false)
    end
  end
end
