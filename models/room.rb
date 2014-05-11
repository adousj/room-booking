class Room < ActiveRecord::Base
  validates_presence_of :name

  has_many :applications
end

class Rooom
  @@rooms = (1..14).map {|i| eval "{ :room#{i} => i}" }.inject &:merge

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