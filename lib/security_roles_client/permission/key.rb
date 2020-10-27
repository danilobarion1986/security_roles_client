# frozen_string_literal: true

module SecurityRolesClient
  module Permission
    # Class responsible for keep the accesses that are grouped by a name (key), as informed in the gem configuration.
    class PermissionKey
      attr_reader :name, :accesses

      def initialize(name, accesses)
        @name = name
        @accesses = accesses
      end
    end
  end
end
