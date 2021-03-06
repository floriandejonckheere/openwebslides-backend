# frozen_string_literal: true

module Metadata
  ##
  # Add a `created_at` metadata attribute
  #
  module CreatedAt
    extend ActiveSupport::Concern

    included do
      # Add an entry lambda to resource metadata
      self.metadata += [lambda do |_options, resource|
        {
          :created_at => DateValueFormatter.format(resource._model.created_at)
        }
      end]
    end
  end
end
