# frozen_string_literal: true

module Tweets
  class DeleteService
    include ActionView::RecordIdentifier

    def initialize(tweet)
      @tweet = tweet
    end

    def call
      result = @tweet.destroy
      broadcast_tweet if result

      result
    end

    private

    def broadcast_tweet
      Turbo::MyStreamsChannel.broadcast_remove_to('tweets', target: dom_id(@tweet))
    end
  end
end
