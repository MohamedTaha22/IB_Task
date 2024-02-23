class Api::MessagesController < ApplicationController

  before_action :set_chat, only: [:create,:index]
  before_action :set_message, only: [:show, :update]

  def index
    data = params[:query].present? ? Message.search(params[:query],@chat.id) :
             Message.where(chat_id: @chat.id)

    records = MessageSerializer.new(data).serializable_hash[:data].map{|record| record[:attributes]}
    render json: { data: records}, status: :created
  end


  def show
    data = MessageSerializer.new(@message).serializable_hash[:data][:attributes]
    render json: { data: data}, status: :created
  end

  def create
    number = REDIS.incr("message_count_#{@chat.id}")
    message_attributes = message_params.to_h
    message_attributes["chat_id"] = @chat.id
    CreateMessageWorker.perform_async(message_attributes, number)
    render json: { data: {message_number: number}}, status: :created
  end

  def update
    message_attributes = message_params.to_h
    message_attributes["id"] = @message.id
    UpdateMessageWorker.perform_async(message_attributes)
    render json: { data: {message_number: params[:message_num]}}, status: :created
  end

  private
  def message_params
    permitted_params = [
      :content
    ]
    params.permit(*permitted_params).to_h
  end

  def set_app
    @app = Application.get_id_by_token(params[:token])
  end
  def set_chat
    set_app
    @chat = Chat.get_id_by_app_id_and_number(@app.id,params[:chat_num])
  end
  def set_message
    set_chat
    @message = Message.find_by!(chat_id: @chat.id, number: params[:message_num])
  end
end
