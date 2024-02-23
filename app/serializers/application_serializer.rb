class ApplicationSerializer
  include JSONAPI::Serializer
  attributes  :name, :token, :chat_count
end
