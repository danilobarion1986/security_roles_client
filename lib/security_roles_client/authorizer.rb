# frozen_string_literal: true

module SecurityRolesClient
  # Class responsible for verify if the user has the correct permissions to make some action.
  class Authorizer
    class << self
      # Verify if the user has the permissions to access the desired route/action.
      #
      # @param permission_key [Symbol] permission_key name.
      # @param action [Symbol] name of the action that we want to verify.
      # @param access_token [String] access_token that encodes the user's permissions.
      # @param access_token_parser [Object] object responsible for parse the access_token.
      #
      # @return [Boolean] true if the user can access; otherwise, false.
      def can_access?(permission_key:, action:, access_token:, access_token_parser: default_access_token_parser)
        access_token_parser ||= default_access_token_parser

        parsed_permissions = access_token_parser.call(access_token)

        permission_mapping.can_access?(permission_key, action, parsed_permissions)
      end

      private

      def default_access_token_parser
        @default_access_token_parser ||= SecurityRolesClient.config.access_token_parser
      end

      def permission_mapping
        @permission_mapping ||= SecurityRolesClient.config.permission_mapping
      end
    end
  end
end
