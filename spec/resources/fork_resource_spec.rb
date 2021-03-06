# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForkResource, :type => :resource do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Subject
  #
  subject(:resource) { described_class }

  ##
  # Test variables
  #
  ##
  # Tests
  #
  it { is_expected.to be_abstract }

  describe 'fields' do
    it 'has a valid set of fetchable fields' do
      # Use Resource.fields instead of Resource#fetchable_fields for abstract resources
      expect(described_class.fields).to be_empty
    end

    it 'has a valid set of creatable fields' do
      expect(described_class.creatable_fields).to be_empty
    end

    it 'has a valid set of updatable fields' do
      expect(described_class.updatable_fields).to be_empty
    end

    it 'has a valid set of sortable fields' do
      expect(described_class.sortable_fields).to be_empty
    end
  end
end
