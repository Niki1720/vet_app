class CreateService

  def create(animal_params)
    @animal = Animal.new(animal_params)
    @animal.save
    @animal
  end
end
