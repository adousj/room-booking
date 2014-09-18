class AddIsReadToMessage < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.boolean :is_read
    end

    add_index :messages, :is_read
  end

  def self.down
    change_table :messages do |t|
      t.remove :is_read
    end
  end
end
