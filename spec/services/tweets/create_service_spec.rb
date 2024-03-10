# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweets::CreateService do
  describe '#call' do
    context 'when the tweet is valid' do
      it 'creates a tweet' do
        user = create(:user)
        params = { content: 'My tweet' }
        service = described_class.new(user, params)

        expect { service.call }.to change(Tweet, :count).by(1)
      end

      it 'broadcasts the tweet' do
        user = create(:user)
        params = { content: 'My tweet' }
        service = described_class.new(user, params)

        expect { service.call }.to have_broadcasted_to('tweets').from_channel(Turbo::StreamsChannel)
      end
    end

    context 'when the tweet is invalid' do
      it 'does not create a tweet' do
        user = create(:user)
        params = { content: '' }
        service = described_class.new(user, params)

        expect { service.call }.not_to change(Tweet, :count)
      end

      it 'does not broadcast the tweet' do
        user = create(:user)
        params = { content: '' }
        service = described_class.new(user, params)

        expect { service.call }.not_to have_broadcasted_to('tweets').from_channel(Turbo::StreamsChannel)
      end
    end
  end
end
