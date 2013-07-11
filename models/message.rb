class Message < ActiveRecord::Base
  belongs_to :account

  def before_create
    self.is_read = false
  end
end
