class Application < ActiveRecord::Base
  validates_presence_of :name, :start_at, :end_at
  belongs_to :account

  def before_create
    self.status = 'none'
  end
end
