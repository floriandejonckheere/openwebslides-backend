# frozen_string_literal: true

module PullRequests
  ##
  # Persist a new pull request in database
  #
  class Create < ApplicationService
    def call(pull_request)
      if pull_request.save
        # Check if pull request is mergeable
        PullRequests::CheckWorker.perform_async pull_request.id

        # Generate appropriate notifications
        Notifications::SubmitPR.call pull_request
      end

      pull_request
    end
  end
end
