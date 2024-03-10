# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweets::DeleteService do
  describe '#call' do
    it 'deletes a tweet' do
      tweet = create(:tweet)
      service = described_class.new(tweet)

      expect { service.call }.to change(Tweet, :count).by(-1)
    end

    it 'broadcasts the tweet' do
      tweet = create(:tweet)
      service = described_class.new(tweet)

      expect { service.call }.to have_broadcasted_to('tweets').from_channel(Turbo::StreamsChannel)
    end
  end
end
