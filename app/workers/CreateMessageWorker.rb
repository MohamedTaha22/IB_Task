class CreateMessageWorker
  include Sidekiq::Worker

  def perform(message_attributes, msg_count)
    message= Message.new
    message.number= msg_count
    message.content = message_attributes["content"]
    message.chat_id= message_attributes["chat_id"]
    begin
      message.save!
    rescue ActiveRecord::RecordNotUnique => e
      logger.warn "Message not unique for chat_id=#{message.chat_id} and number=#{message.number}: #{e.message}"
    rescue => e
      raise e
    end
    message.__elasticsearch__.index_document
  end
end