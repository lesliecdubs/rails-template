# frozen_string_literal: true
module ShrineUploadManager
  extend ActiveSupport::Concern

  included do
    respond_to :json
  end

  def image
    cache = ImageUploader.new(:cache)
    file  = cache.upload(file_params[:file])

    render json: { value: file.to_json, url: file.url }
  end

  private

  def file_params
    params.permit(:file)
  end
end
