module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request

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
