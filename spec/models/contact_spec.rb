require 'rails_helper'

describe Contact do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  # 名がなければ無効な状態であること
  it "is invalid without a firstname" do
    contact = FactoryGirl.build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a lastname" do
    contact = FactoryGirl.build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    contact = FactoryGirl.build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: 'Joe', lastname: 'Tester',
      email: "tester@example.com"
    )
    contact = Contact.new(
      firstname: 'Jane', lastname: 'Tester',
      email: "tester@example.com"
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact,
      firstname: "Jane",
      lastname: "Smith"
    )
    expect(contact.name).to eq 'Jane Smith'
  end

  # 文字で姓をフィルタする
  describe 'filter last name by letter' do
    before do
      @smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    # マッチする文字の場合
    context "matching letters" do
      it 'returns a sorted array of results that match' do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    # マッチしない文字の場合
    context "non-matching letters" do
      it 'omits results that do not match' do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end
end