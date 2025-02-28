class CLIP::TextEmbedding
  def initialize(model_path: "multilingual_model/textual.onnx", tokenizer: Tokenizers.from_pretrained("M-CLIP/XLM-Roberta-Large-Vit-B-32"))
    @model = OnnxRuntime::Model.new(model_path)
    @tokenizer = tokenizer
  end

  def call(text)
    tokens = tokenizer.encode(text).ids
    attention_mask = Array.new(tokens.size, 1)
    model.predict({ input_ids: [ tokens ], attention_mask: [ attention_mask ] })["output"].first
  end

  private

  attr_reader :model, :tokenizer
end
