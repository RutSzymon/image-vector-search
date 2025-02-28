ActiveSupport.on_load :active_record do
  $image_embedding = CLIP::ImageEmbedding.new
  $text_embedding = CLIP::TextEmbedding.new
end
