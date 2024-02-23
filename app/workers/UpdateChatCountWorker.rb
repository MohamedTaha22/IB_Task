class UpdateChatCountWorker
  include Sidekiq::Worker
  def perform()
    pattern = 'chat_count_*'
    REDIS.scan_each(match: pattern) do |key|
      app_id = key.split('_').last.to_i
      chat_count = REDIS.get(key).to_i
      Application.where(id: app_id).first!.update(chat_count: chat_count)
    end
  end
end