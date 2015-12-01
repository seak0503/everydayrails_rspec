require 'rails_helper'

describe Contact do
  example '有効なファクトリを持つこと' do
    expect(build(:contact)).to be_valid
  end

  example '名がなければ無効な状態であること' do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  example '性がなければ無効な状態であること' do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  example 'メールアドレスがなければ無効な状態であること' do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  example '重複したメールアドレスなら無効な状態であること' do
    create(:contact, email: 'aaron@example.com')
    contact = build(:contact, email: 'aaron@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  example '連絡先のフルネームを文字列として返すこと' do
    contact = build(:contact,
      firstname: 'Jane',
      lastname: 'Smith'
    )
    expect(contact.name).to eq 'Jane Smith'
  end

  describe '文字で性をフィルタする' do
    before :each do
      @smith = create(:contact,
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = create(:contact,
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = create(:contact,
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    context 'マッチする文字の場合' do
      example 'マッチした結果をソート済みの配列として返すこと' do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context 'マッチしない文字の場合' do
      example 'マッチしなかったものは結果に含まれないこと' do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end
end
