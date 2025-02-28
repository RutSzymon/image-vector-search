class PhotoEmbedJob < ActiveJob::Base
  def perform(photo)
    embedding = $image_embedding.call(photo.file_path)
    photo.update(embedding:)
  end
end
