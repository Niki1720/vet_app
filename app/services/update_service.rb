class UpdateService

  def update(id, animal_params)
    @animal = Animal.find(id)
    @animal.update(animal_params)
    @animal
  end
end
