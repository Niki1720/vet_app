class ErrorSerializer
  include JSONAPI::Serializer

  def initialize(model)
    @model = model
  end

  def serialized_json
    errors = @model.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          status: "422",
          source: { pointer: "/data/attributes/#{field}" },
          title:  "Invalid Attribute",
          detail: error_message
        }
      end
    end
    errors.flatten
  end
end
