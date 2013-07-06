class AddAccountToMessage < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.integer :account_id
    end
  end

  def self.down
    change_table :messages do |t|
      t.remove :account_id
    end
  end
end
