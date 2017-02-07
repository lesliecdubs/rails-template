# frozen_string_literal: true
require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :direct_upload
Shrine.plugin :determine_mime_type

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("tmp", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("tmp", prefix: "uploads/store"), # permanent
}

class RedactorUploaderMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    result = @app.call(env)

    if result[0] == 200 && env["PATH_INFO"].end_with?("upload")
      redactor_image = RedactorImage.new(image: result[2].first)

      if redactor_image.save
        # response
        result[0] = 201
        # data
        result[2] = [{ id: redactor_image.image.id, url: redactor_image.image_url(public: true) }.to_json]

      else
        result[0] = 500
      end
    end

    result
  end
end

Shrine::UploadEndpoint.use RedactorUploaderMiddleware
