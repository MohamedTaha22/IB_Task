class ChatSerializer
  include JSONAPI::Serializer
  attributes  :number, :msg_count
end
