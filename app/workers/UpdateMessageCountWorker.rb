class UpdateMessageCountWorker
  include Sidekiq::Worker
  def perform()
    pattern = 'message_count_*'
    REDIS.scan_each(match: pattern) do |key|
      chat_id = key.split('_').last.to_i
      message_count = REDIS.get(key).to_i
      Chat.where(id: chat_id).first!.update(msg_count: message_count)
    end
  end
end