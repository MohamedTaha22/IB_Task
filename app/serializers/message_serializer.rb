class MessageSerializer
  include JSONAPI::Serializer
  attributes  :number, :content
end
