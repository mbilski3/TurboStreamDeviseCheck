# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetsController do
  describe 'GET #index' do
    it 'returns a success response' do
      sign_in create(:user)
      get :index
      expect(response).to be_successful
    end

    it 'assigns @tweets as all ordering created_at desc' do
      sign_in create(:user)
      tweets = create_list(:tweet, 3)
      get :index
      expect(assigns(:tweets)).to eq(tweets.reverse)
    end

    it 'renders index' do
      sign_in create(:user)
      create_list(:tweet, 3)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #actions' do
    it 'returns a success response' do
      user = create(:user)
      sign_in user
      tweet = create(:tweet, user: user)
      get :actions, params: { id: tweet.id }
      expect(response).to be_successful
    end

    it 'assigns @tweet' do
      user = create(:user)
      sign_in user
      tweet = create(:tweet, user: user)
      get :actions, params: { id: tweet.id }
      expect(assigns(:tweet)).to eq(tweet)
    end

    it 'renders actions' do
      user = create(:user)
      sign_in user
      tweet = create(:tweet, user: user)
      get :actions, params: { id: tweet.id }
      expect(response).to render_template('tweets/_actions')
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      sign_in create(:user)
      get :new
      expect(response).to be_successful
    end

    it 'assigns @tweet' do
      sign_in create(:user)
      get :new
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end

    it 'renders new' do
      sign_in create(:user)
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'redirects to tweets_path with notice' do
      user = create(:user)
      sign_in user
      post :create, params: { tweet: { content: 'Hello, World!' } }
      expect(response).to redirect_to(tweets_path)
      expect(flash[:notice]).to eq('Tweet was successfully created.')
    end

    it 'renders new' do
      user = create(:user)
      sign_in user
      post :create, params: { tweet: { content: '' } }
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys tweet with notice' do
      user = create(:user)
      sign_in user
      tweet = create(:tweet, user: user)
      delete :destroy, params: { id: tweet.id }
      expect(flash[:notice]).to eq('Tweet was successfully destroyed.')
    end
  end
end
