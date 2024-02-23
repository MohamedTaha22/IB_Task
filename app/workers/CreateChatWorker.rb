class CreateChatWorker
  include Sidekiq::Worker

  def perform(app_id, chat_count)
    chat= Chat.new
    chat.number= chat_count
    chat.application_id= app_id
    chat.save!
  end
end