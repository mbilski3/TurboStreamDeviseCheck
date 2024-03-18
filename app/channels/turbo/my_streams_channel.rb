# frozen_string_literal: true

module Turbo
  class MyStreamsChannel < Turbo::StreamsChannel
    def subscribed
      if (stream_name = verified_stream_name_from_params).present? &&
         subscription_allowed?
        stream_from stream_name
      else
        reject
      end
    end

    private

    def subscription_allowed?
      warden.authenticate?
    end

    def warden
      connection.env['warden']
    end
  end
end
