class Photo < ApplicationRecord
  has_one_attached :file
  has_neighbors :embedding, dimensions: 512

  after_create :embed

  def similar
    nearest_neighbors(:embedding, distance: :cosine)
  end

  def self.by_description(description)
    embedding = $text_embedding.call(description)
    nearest_neighbors(:embedding, embedding, distance: :cosine)
  end

  def self.by_image(image)
    embedding = $image_embedding.call(image.path)
    nearest_neighbors(:embedding, embedding, distance: :cosine)
  end

  def file_path
    ActiveStorage::Blob.service.send(:path_for, file.key)
  end

  def embed
    PhotoEmbedJob.perform_later(self)
  end
end
