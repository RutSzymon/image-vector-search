class CLIP::TextEmbedding
  def initialize(model_path: "model/textual.onnx", preprocessor: CLIP::Tokenizer.new)
    @model = OnnxRuntime::Model.new(model_path)
    @preprocessor = preprocessor
  end

  def call(text)
    tokens = preprocessor.preprocess(text).to_a
    model.predict({ input: [ tokens ] })["output"].first
  end

  private

  attr_reader :model, :preprocessor
end
