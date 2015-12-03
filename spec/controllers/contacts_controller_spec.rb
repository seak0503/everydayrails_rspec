require 'rails_helper'

describe ContactsController do

  describe 'GET#index' do
    context 'params[:litter]がある場合' do
      example '指定された文字で始まる連絡先を配列にまとめること'
      example ':indexテンプレートを表示すること'
    end

    context 'parmas[:letter]がない場合' do
      example '全ての連絡先を配列にまとめること'
      example ':indexテンプレートを表示すること'
    end
  end

  describe 'GET#show' do
    example '@contactに要求された連絡先を割り当てること'
    example ':showテンプレートを表示すること'
  end

  describe 'GET#new' do
    example '@contactに新しい連絡先を割り当てること'
    example ':newテンプレートを表示すること'
  end

  describe 'GET#edit' do
    example '@contactに要求された連絡先を割り当てること'
    example ':editテンプレートを表示すること'
  end

  describe 'POST#create' do
    context '有効な属性の場合' do
      example 'データベースに新しい連絡先を割り当てること'
      example 'contacts#showにリダイレクトすること'
    end

    context '無効な属性の場合' do
      example 'データベースに新しい連絡先を保存しないこと'
      example ' :newテンプレートを再表示すること'
    end
  end

  describe 'PATCH#update' do
    context '有効な属性の場合' do
      example 'データベースの連絡先を更新すること'
      example '更新した連絡先のページへリダイレクトすること'
    end

    context '無効な属性の場合' do
      example '連絡先を更新しないこと'
      example ':editレンプレートを再表示すること'
    end
  end

  describe 'DELETE#destroy' do
    example 'データベースから連絡先を削除すること'
    example 'contacts#indexにリダイレクトすること'
  end
end

