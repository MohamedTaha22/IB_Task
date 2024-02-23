class Api::ApplicationsController < ApplicationController

  before_action :set_app, only: [:show, :update]

  def show
    data = ApplicationSerializer.new(@app).serializable_hash[:data][:attributes]
    render json: { data: data}, status: :created
  end

  def create
    app = Application.new(application_params)
    if app.save
      data = ApplicationSerializer.new(app).serializable_hash[:data][:attributes]
      render json: { data: data }, status: :created
    end
  end

  def update
    if @app.update(application_params)
      data = ApplicationSerializer.new(@app).serializable_hash[:data][:attributes]
      render json: { data: data}, status: :created
    end
  end

  private
  def application_params
    permitted_params = [
      :name,
    ]
    params.permit(*permitted_params)
  end

  def set_app
    @app = Application.find_by!(token: params[:token])
  end
end
