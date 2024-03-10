# frozen_string_literal: true

module Tweets
  class CreateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      tweet = @user.tweets.new(@params)
      result = tweet.save
      broadcast_tweet(tweet) if result

      result
    end

    private

    def broadcast_tweet(tweet)
      Turbo::StreamsChannel.broadcast_prepend_to(
        'tweets',
        target: 'tweets',
        partial: 'tweets/tweet',
        locals: { tweet: tweet, stream: true }
      )
    end
  end
end
