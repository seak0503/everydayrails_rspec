require 'rails_helper'

describe Contact do
  # 姓と名とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end
  # 名がなければ無効な状態であること
  it "is invalid without a firstname"
  # 姓がなければ無効な状態であること
  it "is invalid without a lastname"
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address"
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"
  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string"
end