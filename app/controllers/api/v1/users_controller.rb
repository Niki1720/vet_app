module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: serializer.new(@users).serializable_hash.to_json
      end

      def serializer
        UserSerializer
      end
    end
  end
end
