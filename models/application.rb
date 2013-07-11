class Application < ActiveRecord::Base
  validates_presence_of :name, :start_at, :end_at

  @@statuses = { :unaudited => 'unaudited',
                 :approved => 'approved',
                 :denied => 'denied' }
                 
  def self.statuses
    @@statuses
  end

  def before_craete
    self.status = @@statuses[:unaudited]
  end

  belongs_to :account
end
