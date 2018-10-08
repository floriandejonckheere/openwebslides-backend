# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingPolicy do
  subject { described_class.new user, rating }

  let(:rating) { build :rating, :user => user, :annotation => topic.conversations.first }

  context 'when a topic is public' do
    let(:topic) { build :topic, :with_conversations, :with_collaborators, :state => :public_access }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { build :user }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end
  end

  context 'when a topic is protected' do
    let(:topic) { build :topic, :with_conversations, :with_collaborators, :state => :protected_access }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { build :user }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end
  end

  context 'when a topic is private' do
    let(:topic) { build :topic, :with_conversations, :with_collaborators, :state => :private_access }

    context 'when the user is a guest' do
      let(:user) { nil }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { build :user }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
    end

    context 'when the user is a collaborator' do
      let(:user) { topic.collaborators.first }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end

    context 'when the user is a user' do
      let(:user) { topic.user }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
    end
  end
end
