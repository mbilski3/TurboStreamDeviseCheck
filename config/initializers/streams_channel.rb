# frozen_string_literal: true

module Turbo
  class StreamsChannel
    def subscribed
      reject
    end
  end
end
