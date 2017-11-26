# frozen_string_literal: true

# inlined from https://github.com/doorkeeper-gem/doorkeeper-grants_assertion
# can be switched to GEM if updated doorkeeper-grants_assertion gem version is released (> 0.0.1)

require 'doorkeeper/request/assertion'

module Doorkeeper
  module GrantsAssertion
    def resource_owner_from_assertion
      instance_eval(&Doorkeeper.configuration.resource_owner_from_assertion)
    end
  end
end

module Doorkeeper
  class Server
    def resource_owner_from_assertion
      context.send :resource_owner_from_assertion
    end
  end
end

module Doorkeeper
  class Config
    option :resource_owner_from_assertion, default: (lambda do |_|
      warn(I18n.t('doorkeeper.errors.messages.assertion_flow_not_configured'))
      nil
    end)
  end
end

Doorkeeper::Helpers::Controller.send :include, Doorkeeper::GrantsAssertion
