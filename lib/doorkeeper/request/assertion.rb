# frozen_string_literal: true

# inlined from https://github.com/doorkeeper-gem/doorkeeper-grants_assertion
# can be switched to GEM if updated doorkeeper-grants_assertion gem version is released (> 0.0.1)

module Doorkeeper
  module Request
    class Assertion < Strategy
      delegate :credentials, :resource_owner_from_assertion, :parameters, to: :server
      delegate :authorize, to: :request

      def request
        @request ||= OAuth::PasswordAccessTokenRequest.new(
          Doorkeeper.configuration,
          client,
          resource_owner_from_assertion,
          parameters
        )
      end

      private

      def client
        if credentials
          server.client
        elsif parameters[:client_id]
          server.client_via_uid
        end
      end
    end
  end
end
