# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicResource, :type => :resource do
  let(:topic) { create :topic }
  let(:context) { {} }

  let(:nil_topic) { create :topic, :description => nil }

  subject { described_class.new topic, context }

  it { is_expected.to have_primary_key :id }

  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :access }
  it { is_expected.to have_attribute :root_content_item_id }
  it { is_expected.to have_attribute :description }

  it { is_expected.to have_one :user }
  it { is_expected.to have_one :upstream }
  it { is_expected.to have_one :content }

  it { is_expected.to have_many(:collaborators).with_class_name 'User' }
  it { is_expected.to have_many(:forks).with_class_name 'Topic' }
  it { is_expected.to have_many(:assets) }
  it { is_expected.to have_many(:conversations) }
  it { is_expected.to have_many(:incoming_pull_requests).with_class_name 'PullRequest' }
  it { is_expected.to have_many(:outgoing_pull_requests).with_class_name 'PullRequest' }

  describe 'fields' do
    it 'should have a valid set of fetchable fields' do
      expect(subject.fetchable_fields).to match_array %i[id title access description root_content_item_id user upstream content forks collaborators assets conversations incoming_pull_requests outgoing_pull_requests]
    end

    it 'should omit empty fields' do
      subject { described_class.new nil_topic, context }
      expect(subject.fetchable_fields).to match_array %i[id title access description root_content_item_id user upstream content forks collaborators assets conversations incoming_pull_requests outgoing_pull_requests]
    end

    it 'should have a valid set of creatable fields' do
      expect(described_class.creatable_fields).to match_array %i[title access description root_content_item_id user]
    end

    it 'should have a valid set of updatable fields' do
      expect(described_class.updatable_fields).to match_array %i[title access description user]
    end

    it 'should have a valid set of sortable fields' do
      expect(described_class.sortable_fields context).to match_array %i[id title access description]
    end
  end

  describe 'filters' do
    it 'should have a valid set of filters' do
      expect(described_class.filters.keys).to match_array %i[id title access description]
    end

    let(:verify) { described_class.filters[:access][:verify] }

    it 'should verify access' do
      expect(verify.call(%w[public foo protected private bar], {}))
        .to match_array %w[public protected private]
    end
  end
end
