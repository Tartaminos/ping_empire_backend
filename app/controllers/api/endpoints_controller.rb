module Api
  class EndpointsController < ApplicationController
    before_action :set_endpoint_api, only: [ :show, :update, :destroy ]

    def index
      @endpoints = @user.endpoints
      render json: @endpoints, status: :ok
    end

    def show
      render json: @endpoint, status: :ok
    end

    def create
      @endpoint = @user.endpoints.new(endpoint_params)
      if @endpoint.save
        render json: @endpoint, status: :created
      else
        render json: { errors: @endpoint.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @endpoint.update(endpoint_params)
        render json: @endpoint, status: :ok
      else
        render json: { errors: @endpoint.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @endpoint.destroy
      head :no_content
    end

    private

    def set_endpoint_api
      @endpoint = @user.endpoints.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Endpoint not found." }, status: :not_found
    end

    def endpoint_params
      params.require(:endpoints).permit(:url, :status, :description)
    end
  end
end
