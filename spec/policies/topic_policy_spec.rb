# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicPolicy do
  subject { described_class.new user, topic }

  let(:topic) { build :topic, :state => :public_access, :user => user }

  context 'for a guest' do
    let(:user) { nil }

    it { is_expected.to permit_action :index }
    it { is_expected.to forbid_action :create }

    it 'should not permit :create for another user' do
      expect(described_class.new(build(:user), topic)).to forbid_action :create
    end

    context 'for public topics' do
      let(:topic) { build :topic, :state => :public_access }
      it 'should permit only read' do
        expect(subject).to permit_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for protected topics' do
      let(:topic) { build :topic, :state => :protected_access }
      it 'should not permit anything' do
        expect(subject).to forbid_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to forbid_action :show_user
        expect(subject).to forbid_action :show_collaborators
        expect(subject).to forbid_action :show_assets
        expect(subject).to forbid_action :show_notifications
        expect(subject).to forbid_action :show_conversations
        expect(subject).to forbid_action :show_annotations
      end
    end

    context 'for private topics' do
      let(:topic) { build :topic, :state => :private_access }
      it 'should not permit anything' do
        expect(subject).to forbid_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to forbid_action :show_user
        expect(subject).to forbid_action :show_collaborators
        expect(subject).to forbid_action :show_assets
        expect(subject).to forbid_action :show_notifications
        expect(subject).to forbid_action :show_conversations
        expect(subject).to forbid_action :show_annotations
      end
    end
  end

  context 'for a user' do
    let(:user) { build :user }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :create }

    it 'should not permit :create for another user' do
      expect(described_class.new(build(:user), topic)).to forbid_action :create
    end

    context 'for public topics' do
      let(:topic) { build :topic, :state => :public_access }
      it 'should permit only read' do
        expect(subject).to permit_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for protected topics' do
      let(:topic) { build :topic, :state => :protected_access }
      it 'should permit only read' do
        expect(subject).to permit_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for private topics' do
      let(:topic) { build :topic, :state => :private_access }
      it 'should not permit anything' do
        expect(subject).to forbid_action :show
        expect(subject).to forbid_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to forbid_action :show_user
        expect(subject).to forbid_action :show_collaborators
        expect(subject).to forbid_action :show_assets
        expect(subject).to forbid_action :show_notifications
        expect(subject).to forbid_action :show_conversations
        expect(subject).to forbid_action :show_annotations
      end
    end
  end

  context 'for a collaborator' do
    let(:user) { build :user, :with_topics }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :create }

    it 'should not permit :create for another user' do
      expect(described_class.new(build(:user), topic)).to forbid_action :create
    end

    context 'for public topics' do
      let(:topic) { build :topic, :with_collaborators, :state => :public_access }
      let(:user) { topic.collaborators.first }
      it 'should permit update' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for protected topics' do
      let(:topic) { build :topic, :with_collaborators, :state => :protected_access }
      let(:user) { topic.collaborators.first }
      it 'should not permit anything' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for private topics' do
      let(:topic) { build :topic, :with_collaborators, :state => :private_access }
      let(:user) { topic.collaborators.first }
      it 'should not permit anything' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to forbid_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end
  end

  context 'for a user' do
    let(:user) { build :user, :with_topics }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :create }

    it 'should not permit :create for another user' do
      expect(described_class.new(build(:user), topic)).to forbid_action :create
    end

    context 'for public topics' do
      let(:topic) { build :topic, :state => :public_access }
      let(:user) { topic.user }
      it 'should permit everything' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to permit_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for protected topics' do
      let(:topic) { build :topic, :state => :protected_access }
      let(:user) { topic.user }
      it 'should permit everything' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to permit_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end

    context 'for private topics' do
      let(:topic) { build :topic, :state => :private_access }
      let(:user) { topic.user }
      it 'should permit everything' do
        expect(subject).to permit_action :show
        expect(subject).to permit_action :update
        expect(subject).to permit_action :destroy

        expect(subject).to permit_action :show_user
        expect(subject).to permit_action :show_collaborators
        expect(subject).to permit_action :show_assets
        expect(subject).to permit_action :show_notifications
        expect(subject).to permit_action :show_conversations
        expect(subject).to permit_action :show_annotations
      end
    end
  end
end