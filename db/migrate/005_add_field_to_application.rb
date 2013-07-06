class AddFieldToApplication < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.string :status
    end
  end

  def self.down
    change_table :applications do |t|
      t.remove :status
    end
  end
end
