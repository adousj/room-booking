class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.string :email
      t.string :phone
      t.string :status
      t.integer :account_id
      t.timestamps
    end

    add_index :applications, :status
    add_index :applications, :account_id
    add_index :applications, :start_at
    add_index :applications, :end_at
  end

  def self.down
    drop_table :applications
  end
end
