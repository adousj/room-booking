class AddIsReadToMessage < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.boolean :is_read
    end
  end

  def self.down
    change_table :messages do |t|
      t.remove :is_read
    end
  end
end
