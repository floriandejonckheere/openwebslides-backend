# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repo::Filesystem::Delete do
  ##
  # Configuration
  #
  include_context 'repository'

  ##
  # Subject
  #
  ##
  # Test variables
  #
  let(:repo) { Repository.new :topic => create(:topic) }

  ##
  # Stubs and mocks
  #
  ##
  # Tests
  #
  context 'when the repository does not exist' do
    it 'raises a RepoDoesNotExistError' do
      expect { subject.call repo }.to raise_error OpenWebslides::Repo::RepoDoesNotExistError
    end
  end

  context 'when the repository already exists' do
    before { Repo::Create.call repo.topic }

    it 'deletes the repository structure' do
      subject.call repo

      expect(File).not_to exist repo.path
    end
  end
end
