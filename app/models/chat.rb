class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy

  scope :get_id_by_app_id_and_number, -> (app_id, number) {
    where(application_id: app_id, number: number).select(:id).first!
  }
end
