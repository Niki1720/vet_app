class AnimalSerializer
  include JSONAPI::Serializer

  attributes :name, :species
  attribute :birth do |animal|
    animal.birth.strftime('%Y-%m-%d') if animal.birth?
  end

  attribute :death do |animal|
    animal.death.strftime('%Y-%m-%d') if animal.death?
  end

  belongs_to :user
end
