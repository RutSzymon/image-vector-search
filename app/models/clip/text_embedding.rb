class CLIP::TextEmbedding
  def initialize(model_path: "model/textual.onnx", tokenizer: CLIP::Tokenizer.new)
    @model = OnnxRuntime::Model.new(model_path)
    @tokenizer = tokenizer
  end

  def call(text)
    tokens = tokenizer.encode(text)
    model.predict({ input: [ tokens ] })["output"].first
  end

  private

  attr_reader :model, :tokenizer
end
