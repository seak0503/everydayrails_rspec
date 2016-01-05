require 'rails_helper'

describe UsersController do
  describe 'user access' do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    describe 'GET #index' do
      example 'ユーザーを@userに集めること' do
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [@user, user]
      end

      example 'index テンプレートを表示すること' do
        get :index
        expect(response).to render_template :index
      end
    end

    example 'GET #new denies access' do
      get :new
      expect(response).to redirect_to root_url
    end

    example 'POST #create denies access' do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to root_url
    end
  end
end