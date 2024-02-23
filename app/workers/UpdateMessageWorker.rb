class UpdateMessageWorker
  include Sidekiq::Worker

  def perform(message_attributes)
    message= Message.find message_attributes["id"]
    message.update!(content: message_attributes["content"] )
  end
end