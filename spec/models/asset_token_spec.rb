# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Asset::Token, :type => :model do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Subject
  #
  subject(:asset_token) { build :asset_token, :subject => user, :object => asset }

  ##
  # Test variables
  #
  let(:lifetime) { OpenWebslides.config.api.asset_url_lifetime.from_now.to_i }
  let(:user) { create :user, :confirmed }
  let(:asset) { create :asset, :with_topic }

  describe 'attributes' do
    it { is_expected.to be_a Asset::Token }
    it { is_expected.to respond_to :object }
  end

  describe 'methods' do
    # Serialize and deserialize object to let JWT::Auth::Token
    # fill in the defaults for all attributes
    subject(:token) { Asset::Token.from_token asset_token.to_jwt }

    describe '#valid?' do
      it { is_expected.to be_valid }

      context 'without token' do
        before { token.object = nil }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe 'from token' do
    let(:jwt) do
      payload = {
        :exp => lifetime,
        :sub => user.id,
        :obj => asset.id
      }
      JWT.encode payload, Rails.application.secrets.secret_key_base
    end

    let(:token) { Asset::Token.from_token jwt }

    describe '#from_token' do
      it { is_expected.to have_attributes :object => asset }
    end
  end
end
