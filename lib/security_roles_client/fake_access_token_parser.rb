# frozen_string_literal: true

module SecurityRolesClient
  class FakeAccessTokenParser
    MSG = <<-MSG
      Warning:

      > You are using the 'FakeAccessTokenParser' class.
      > You should configure the access token parser using the following configuration:
      >
      > SecurityRolesClient.config.access_token_parser = -> (token) { 'parse the token here' }
      >
      > You can see more details in the README.

    MSG

    def self.call(access_token)
      puts MSG

      access_token
    end
  end
end
