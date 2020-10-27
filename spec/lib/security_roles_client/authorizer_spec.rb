# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SecurityRolesClient::Authorizer do
  describe '.can_access?' do
    subject { described_class }

    before do
      SecurityRolesClient.config.permission_mapping = {
        permission_keys: [
          {
            key: :default,
            accesses: {
              index: :list
            }
          }
        ]
      }
    end

    context 'when the permission key is not in the permissions mapping configuration' do
      let(:params) do
        {
          permission_key: :other,
          action: :index,
          access_token: { default: { access: [:read] } }
        }
      end

      it 'denies the access' do
        expect(subject.can_access?(params)).to eql false
      end
    end

    context 'when the key does not have the action mapped' do
      let(:params) do
        {
          permission_key: :default,
          action: :bulk,
          access_token: { default: { access: [:read] } }
        }
      end

      it 'denies the access' do
        expect(subject.can_access?(params)).to eql false
      end
    end

    context 'when the access_token does not allow the action' do
      let(:params) do
        {
          permission_key: :default,
          action: :index,
          access_token: { default: { access: [:read] } }
        }
      end

      it 'denies the access' do
        expect(subject.can_access?(params)).to eql false
      end
    end

    context 'when the permission mapping configuration is correct and the access_token allows the action' do
      let(:params) do
        {
          permission_key: :default,
          action: :index,
          access_token: { default: { access: [:list] } }
        }
      end

      it 'allows the access' do
        expect(subject.can_access?(params)).to eql true
      end
    end
  end
end
