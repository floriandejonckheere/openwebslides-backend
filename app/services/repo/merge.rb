# frozen_string_literal: true

module Repo
  ##
  # Merge two repositories
  #
  class Merge < ApplicationService
    include Helpers::Lockable

    def call(source, target, user, message)
      # Repo where commits are taken from
      source_repo = Repository.new :topic => source
      # Repo where commits are added toZ
      target_repo = Repository.new :topic => target

      remote_name = "topic_#{source.id}"

      read_lock source do
        write_lock target do
          # Add source repo remote and fetch
          Repo::Git::Remote::Add.call target_repo, remote_name, source_repo.path
          Repo::Git::Remote::Fetch.call target_repo, remote_name

          # Find out commit to merge
          commit = Repo::Git::Log.call(source_repo).last

          # Create merge commit
          Repo::Git::Merge.call target_repo, commit, user, message

          # Update timestamps
          target.touch
        end
      end
    ensure
      # Remove target's source remote
      Repo::Git::Remote::Remove.call target_repo, remote_name
    end
  end
end
