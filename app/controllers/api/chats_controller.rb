class Api::ChatsController < ApplicationController

  before_action :set_app, only: [:create]
  before_action :set_chat, only: [:show]

  def show
    data = ChatSerializer.new(@chat).serializable_hash[:data][:attributes]
    render json: { data: data}, status: :created
  end

  def create
    number = REDIS.incr("chat_count_#{@app.id}")
    CreateChatWorker.perform_async(@app.id, number)
    render json: { data: {chat_number: number }}, status: :created
  end

  private
  def set_app
    @app = Application.get_id_by_token(params[:token])
  end
  def set_chat
    set_app
    @chat = Chat.where(application_id: @app.id, number: params[:chat_num])
                .select(:number, :msg_count).first!
  end
end
