# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssetResource, :type => :resource do
  let(:asset) { create :asset, :with_topic }
  let(:context) { {} }

  before do
    create :user

    # Stub AssetResource#context to return a dummy request context
    allow(subject).to receive(:context)
      .and_return(:current_user => User.first)
  end

  subject { described_class.new asset, context }

  it { is_expected.to have_primary_key :id }

  it { is_expected.to be_immutable }

  it { is_expected.to have_attribute :filename }

  it { is_expected.to have_one :topic }

  describe 'fields' do
    it 'should have a valid set of fetchable fields' do
      expect(subject.fetchable_fields).to match_array %i[id filename topic]
    end

    it 'should have a valid set of creatable fields' do
      expect(described_class.creatable_fields).to match_array %i[filename topic]
    end

    it 'should have a valid set of updatable fields' do
      expect(described_class.updatable_fields).to be_empty
    end

    it 'should have a valid set of sortable fields' do
      expect(described_class.sortable_fields context).to match_array %i[id filename]
    end

    it 'should have a custom link' do
      expect(subject).to respond_to :custom_links
    end
  end

  describe 'filters' do
    it 'should have a valid set of filters' do
      expect(described_class.filters.keys).to match_array %i[id filename]
    end
  end
end
