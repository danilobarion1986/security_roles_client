# frozen_string_literal: true

module SecurityRolesClient
  module Permission
    # Class responsible for store the project's permission mapping configuration
    # in a way that can be used by the Authorizer to validate user access.
    class Mapping
      EMPTY_ACCESSES = { access: [] }.freeze

      attr_reader :keys

      def initialize(keys)
        @keys = keys
      end

      # @param permission_key [Symbol] permission key name to verify.
      # @param action [Symbol] name of the action to verify.
      # @param parsed_permissions [Object] user's parsed permissions.
      #
      # @return [Boolean] true if the user has access; otherwise, false.
      def can_access?(permission_key, action, parsed_permissions)
        # If the key is not in the permissions mapping configuration, the access is denied
        key_obj = keys.detect { |key| key.name == permission_key }
        return false unless key_obj

        # If the key does not have the action mapped, the access is denied
        action_key = key_obj.accesses[action]
        return false unless action_key

        # If all permissions mapping configuration are good,
        # check if the desired action is allowed
        allowed_actions_keys = (parsed_permissions[permission_key] || EMPTY_ACCESSES)[:access]
        allowed_actions_keys.include?(action_key)
      end
    end
  end
end
