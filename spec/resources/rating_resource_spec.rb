# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingResource, :type => :resource do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Test variables
  #
  subject { described_class.new rating, context }

  let(:rating) { create :rating }
  let(:context) { {} }

  ##
  # Subject
  #

  ##
  # Tests
  #
  it { is_expected.to have_primary_key :id }

  it { is_expected.to have_one :annotation }
  it { is_expected.to have_one :user }

  describe 'fields' do
    it 'has a valid set of creatable fields' do
      expect(described_class.creatable_fields).to match_array %i[annotation user]
    end
  end
end
