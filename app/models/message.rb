class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :chat
  mapping do
    indexes :content, type: 'text'
  end

  def self.search(query, chat_id)
    params = {
      query: {
        bool: {
          must: {
            match: {
              content: query,
            }
          },
          filter: {
            term: {
              chat_id: chat_id
            }
          }
        }
      }
    }
    self.__elasticsearch__.search(params).records.to_a
  end

end
