# frozen_string_literal: true

module Repository
  module Asset
    ##
    # Update an asset in the backing store with a string
    #
    class Update < AssetCommand
      attr_accessor :author, :content

      def execute
        raise OpenWebslides::ArgumentError, 'No author specified' unless @author
        raise OpenWebslides::ArgumentError, 'No content specified' unless @content

        exists = File.exist? asset_file

        # Write asset file
        exec Asset::Write do |c|
          c.content = @content
        end

        # Commit
        exec_topic Git::Commit do |c|
          c.author = @author
          c.message = "#{exists ? 'Update' : 'Add'} #{@receiver.filename}"
        end

        # Update timestamps
        @receiver.touch
        @receiver.topic.touch
      end
    end
  end
end
