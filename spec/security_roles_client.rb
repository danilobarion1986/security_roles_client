# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SecurityRolesClient do
  it 'has a version number' do
    expect(SecurityRolesClient::VERSION).to_not be_nil
  end

  describe 'Configuration' do
    subject { SecurityRolesClient.config }

    it 'has the correct configurations' do
      expect(subject.access_token_parser).to eql SecurityRolesClient::FakeAccessTokenParser
      expect(subject.permission_mapping).to be_a SecurityRolesClient::Permission::Mapping
    end

    context 'incorrect configurations' do
      context 'when access_token_parser does not respond to .call(access_token)' do
        it 'raises InvalidSettingError' do
          expect do
            subject.access_token_parser = Object.new
          end.to raise_error(SecurityRolesClient::InvalidSettingError,
                             'Value should be an object that responds to .call(access_token).')
        end
      end

      context 'when permission_mapping does not have the correct schema' do
        it 'raises InvalidSettingError' do
          expect do
            subject.permission_mapping = Object.new
          end.to raise_error(SecurityRolesClient::InvalidSettingError,
                             /permission_keys.*is missing/)
        end
      end
    end
  end
end
