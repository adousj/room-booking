class AddTeamTypeToApplications < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.integer :team_type
    end
  end

  def self.down
    change_table :applications do |t|
      t.remove :team_type
    end
  end
end
