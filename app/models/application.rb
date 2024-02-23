class Application < ApplicationRecord
  require 'ulid'
  before_create :set_token
  has_many :chats, dependent: :destroy

  scope :get_id_by_token , -> (token) {
    where(token: token).select(:id).first!
  }
  private
  def set_token
    self.token = ULID.generate
  end
end
