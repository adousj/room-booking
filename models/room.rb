class Room < ActiveRecord::Base
  validates_presence_of :name

  has_many :applications
end

class Rooom
  @@rooms = { :room1 => 1,
              :room2 => 2,
              :room3 => 3,
              :room4 => 4,
              :room5 => 5,
              :room6 => 6,
              :room7 => 7 }

  @@rooms.keys.each do |key|
    eval """
      def #{key}
        @@rooms[key]
      end
    """
  end

  def self.rooms
    @@rooms
  end
end