class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :content
      t.integer :account_id
      t.timestamps
    end

    add_index :messages, :account_id
  end

  def self.down
    drop_table :messages
  end
end
