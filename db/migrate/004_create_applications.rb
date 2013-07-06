class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.string :email
      t.string :phone
      t.integer :account_id
      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
