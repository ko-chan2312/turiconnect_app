require 'rails_helper'

RSpec.describe User, type: :model do
it "名、メール、パスワードがあれば有効なこと" do
  user = User.new(
  name: "john",
  email: "abcd@yahoo.co.jp",
  password: "ripla77",
  )
  expect(user).to be_valid
end
end
