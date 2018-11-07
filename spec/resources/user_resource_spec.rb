# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserResource, :type => :resource do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Test variables
  #
  subject { described_class.new user, context }

  let(:user) { create :user }
  let(:context) { {} }

  ##
  # Subject
  #

  ##
  # Tests
  #
  it { is_expected.to have_primary_key :id }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :gravatar_hash }
  it { is_expected.not_to have_attribute :locale }
  it { is_expected.not_to have_attribute :email }
  it { is_expected.not_to have_attribute :tos_accepted }

  it { is_expected.to have_many(:topics).with_class_name 'Topic' }
  it { is_expected.to have_many(:collaborations).with_class_name 'Topic' }

  describe 'fields' do
    context 'for a guest' do
      it 'has a valid set of fetchable fields' do
        expect(subject.fetchable_fields).to match_array %i[id name gravatar_hash topics collaborations]
      end
    end

    context 'for a user' do
      let(:context) { { :current_user => build(:user) } }

      it 'has a valid set of fetchable fields' do
        expect(subject.fetchable_fields).to match_array %i[id name gravatar_hash topics collaborations]
      end
    end

    context 'for the same user' do
      let(:context) { { :current_user => user } }

      it 'has a valid set of fetchable fields' do
        expect(subject.fetchable_fields).to match_array %i[id name locale email gravatar_hash topics collaborations]
      end
    end

    it 'has a valid set of creatable fields' do
      expect(described_class.creatable_fields).to match_array %i[name email locale password tos_accepted]
    end

    it 'has a valid set of updatable fields' do
      expect(described_class.updatable_fields).to match_array %i[name locale password topics collaborations]
    end

    it 'has a valid set of sortable fields' do
      expect(described_class.sortable_fields context).to match_array %i[id name email]
    end
  end

  describe 'filters' do
    it 'has a valid set of filters' do
      expect(described_class.filters.keys).to match_array %i[id name email]
    end
  end
end
