# frozen_string_literal: true

module SecurityRolesClient
  module Permission
    # Class responsible for build a permission mapping to be used by the Authorizer to validate user access.
    class Builder
      # Build a permission mapping to be used internally by the [SecurityRolesClient::Authorizer].
      #
      # @param permission_keys [Array<Hash>] list of permission keys with the accesses allowed in the project.
      #
      # @return [Permission::Mapping] [Permission::Mapping] instance, that will be used internally
      #   by the [SecurityRolesClient::Authorizer] to validate user access.
      def self.call(permission_keys)
        keys = permission_keys.map { |permission| PermissionKey.new(permission[:key], permission[:accesses]) }

        Permission::Mapping.new(keys)
      end
    end
  end
end
