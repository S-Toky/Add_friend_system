class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.integer :friend_id
      t.boolean :confirmed, default: :false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
