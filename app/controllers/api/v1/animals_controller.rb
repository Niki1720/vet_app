module Api
  module V1
    class AnimalsController < ApplicationController
      # skip_before_action :authenticate_request
      before_action :set_user
      before_action :set_animal, only: [:show, :update, :destroy]
      # GET api/v1/animals
      def index
        @animals = Animal.all.where(user_id: @user.id)
        puts @animals.inspect
        render json: serializer.new(@animals).serializable_hash.to_json, status: :ok
      end

      # GET api/v1/animals/1
      def show
        render json: serializer.new(@animal).serializable_hash.to_json, status: :ok
      end

      # POST api/v1/animals
      def create
        @animal = CreateService.new.create(animal_params)
        if @animal.valid?
          render json: serializer.new(@animal).serializable_hash.to_json, status: :ok
        else
          render json: ErrorSerializer.new(@animal).serialized_json, status: :unprocessable_entity
        end
      end

      # PATCH/PUT api/v1/animals/1
      def update
        @animal = UpdateService.new.update(params[:id], animal_params)
        if @animal.valid?
          render json: serializer.new(@animal).serializable_hash.to_json, status: :ok
        else
          render json: ErrorSerializer.new(@animal).serialized_json, status: :unprocessable_entity
        end
      end

      # DELETE api/v1/animals/1
      def destroy
        @animal.destroy
        render json: {}, status: :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_animal
        @animal = Animal.find(params[:id])
      end
      # Only allow a list of trusted parameters through.
      def animal_params
        params.permit(:name, :species, :birth, :death)
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def serializer
        AnimalSerializer
      end
    end
  end
end
