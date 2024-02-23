class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.text :token
      t.text :name
      t.integer :chat_count, default: 0

      t.timestamps
    end
    add_index :applications, :token, unique: true, length: 191
  end
end
