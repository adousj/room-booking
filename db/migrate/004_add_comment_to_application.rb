class AddCommentToApplication < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.string :comment
    end
  end

  def self.down
    change_table :applications do |t|
      t.remove :comment
    end
  end
end
