# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

Mime::Type.register 'image/webp', :webp

module JSONAPI
  # MIME type for file uploads
  UPLOAD_MEDIA_TYPE = 'multipart/form-data'

  # MIME types allowed for file uploads
  ALLOWED_BINARY_MEDIA_TYPES = %w[
    image/png
    image/jpeg
    image/gif
    image/webp
  ].freeze
end
