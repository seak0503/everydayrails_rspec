require 'rails_helper'

describe ContactsController do

  describe 'GET#index' do
    context 'params[:litter]がある場合' do
      example '指定された文字で始まる連絡先を配列にまとめること' do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index, letter: 'S'
        expect(assigns(:contacts)).to match_array([smith])
      end

      example ':indexテンプレートを表示すること' do
        get :index, letter: 'S'
        expect(response).to render_template :index
      end
    end

    context 'parmas[:letter]がない場合' do
      example '全ての連絡先を配列にまとめること' do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index
        expect(assigns(:contacts)).to match_array([smith, jones])
      end

      example ':indexテンプレートを表示すること' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET#show' do
    example '@contactに要求された連絡先を割り当てること' do
      contact = create(:contact)
      get :show, id: contact
      expect(assigns(:contact)).to eq(contact)
    end

    example ':showテンプレートを表示すること' do
      contact = create(:contact)
      get :show, id: contact
      expect(response).to render_template :show
    end
  end

  describe 'GET#new' do
    example '@contactに新しい連絡先を割り当てること' do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    example ':newテンプレートを表示すること' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET#edit' do
    example '@contactに要求された連絡先を割り当てること' do
      contact = create(:contact)
      get :edit, id: contact
      expect(assigns(:contact)).to eq(contact)
    end

    example ':editテンプレートを表示すること' do
      contact = create(:contact)
      get :edit, id: contact
      expect(response).to render_template :edit
    end
  end

  describe 'POST#create' do
    before do
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),
        attributes_for(:phone)
      ]
    end

    context '有効な属性の場合' do
      example 'データベースに新しい連絡先を割り当てること' do
        expect {
          post :create, contact: attributes_for(:contact,
            phones_attributes: @phones)
        }.to change(Contact, :count).by(1)
      end

      example 'contacts#showにリダイレクトすること' do
        post :create, contact: attributes_for(:contact,
          phones_attributes: @phones)
        expect(response).to redirect_to contact_path(assigns[:contact])
      end

    end

    context '無効な属性の場合' do
      example 'データベースに新しい連絡先を保存しないこと' do
        expect{
          post :create,
            contact: attributes_for(:invalid_contact)
        }.not_to change(Contact, :count)
      end

      example ' :newテンプレートを再表示すること' do
        post :create,
          contact: attributes_for(:invalid_contact)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH#update' do
    before do
      @contact = create(:contact,
        firstname: 'Lawrence',
        lastname: 'Smith')
    end

    context '有効な属性の場合' do
      example '要求された@contactを取得すること' do
        patch :update, id: @contact, contact: attributes_for(:contact)
        expect(assigns(:contact)).to eq(@contact)
      end

      example '@contactの属性を変更すること' do
        patch :update, id: @contact,
          contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: 'Smith')
        @contact.reload
        expect(@contact.firstname).to eq('Larry')
        expect(@contact.lastname).to eq('Smith')
      end

      example '更新した連絡先のページへリダイレクトすること' do
        patch :update, id: @contact, contact: attributes_for(:contact)
        expect(response).to redirect_to @contact
      end
    end

    context '無効な属性の場合' do
      example '連絡先を更新しないこと' do
        patch :update, id: @contact,
          contact: attributes_for(:contact,
            firstname: "Larry", lastname: nil)
        @contact.reload
        expect(@contact.firstname).not_to eq("Larry")
        expect(@contact.lastname).to eq("Smith")
      end
      example ':editレンプレートを再表示すること' do
        patch :update, id: @contact,
          contact: attributes_for(:invalid_contact)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE#destroy' do
    example 'データベースから連絡先を削除すること'
    example 'contacts#indexにリダイレクトすること'
  end
end

