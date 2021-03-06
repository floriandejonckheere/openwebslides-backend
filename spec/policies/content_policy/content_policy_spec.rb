# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContentPolicy do
  ##
  # Configuration
  #
  ##
  # Stubs and mocks
  #
  ##
  # Subject
  #
  subject(:policy) { described_class.new user, content }

  ##
  # Test variables
  #
  let(:content) { build :content, :topic => topic }
  let(:topic) { build :topic, :access => :public, :user => user }

  ##
  # Tests
  #
  context 'when the topic is public' do
    let(:topic) { build :topic, :with_collaborators, :access => :public }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to permit_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is just a user' do
      let(:user) { build :user }

      it { is_expected.to permit_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end

    context 'when the user is a topic owner' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end
  end

  context 'when the topic is protected' do
    let(:topic) { build :topic, :with_collaborators, :access => :protected }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is just a user' do
      let(:user) { build :user }

      it { is_expected.to permit_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end

    context 'when the user is a topic owner' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end
  end

  context 'when the topic is private' do
    let(:topic) { build :topic, :with_collaborators, :access => :private }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is just a user' do
      let(:user) { build :user }

      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_action :update }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end

    context 'when the user is a topic owner' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end
  end
end
