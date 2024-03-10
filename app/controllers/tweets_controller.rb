# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def actions
    @tweet = Tweet.find(params[:id])
    render partial: 'actions', locals: { tweet: @tweet }, layout: false
  end

  def new
    @tweet = Tweet.new
  end

  def create
    create_service = Tweets::CreateService.new(current_user, tweet_params)

    if create_service.call
      redirect_to tweets_path, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @tweet = current_user.admin? ? Tweet.find(params[:id]) : current_user.tweets.find(params[:id])
    Tweets::DeleteService.new(@tweet).call
    flash[:notice] = 'Tweet was successfully destroyed.'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
