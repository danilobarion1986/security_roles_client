# frozen_string_literal: true

require 'dry-configurable'
require 'dry-schema'
require 'json'
require 'pry'

require 'security_roles_client/version'
require 'security_roles_client/authorizer'
require 'security_roles_client/fake_access_token_parser'
require 'security_roles_client/permission/builder'
require 'security_roles_client/permission/mapping'
require 'security_roles_client/permission/key'

# Main module
module SecurityRolesClient
  # https://dry-rb.org/gems/dry-configurable/0.11/
  extend Dry::Configurable
  # Basic error class for wrong settings values
  class InvalidSettingError < ArgumentError; end

  DEFAULT_PERMISSION_KEYS = { permission_keys: [{ key: :default, accesses: { index: :list } }] }.freeze

  # Lambda to be called to parse the access_token that has the user permissions. It can
  # be any object that responds to .call, receiving the access_token as the only argument.
  setting :access_token_parser, SecurityRolesClient::FakeAccessTokenParser do |parser|
    unless parser.respond_to?(:call)
      raise InvalidSettingError, 'Value should be an object that responds to .call(access_token).'
    end

    parser
  end

  PermissionMappingSchema = Dry::Schema.Params do
    required(:permission_keys).array(:hash) do
      required(:key).filled(:symbol)
      required(:accesses).maybe(:hash)
    end
  end

  setting :permission_mapping, [] do |permission_map|
    permission_map = permission_map == [] ? DEFAULT_PERMISSION_KEYS : permission_map
    validation_result = PermissionMappingSchema.call(permission_map)
    raise InvalidSettingError, validation_result.errors.to_h unless validation_result.success?

    Permission::Builder.call(validation_result[:permission_keys])
  end
end
