class World < ActiveRecord::Base
  def run
    update_attribute :turn, turn + 1
  end

  def self.instance
    find_or_create_by_id(1)
  end
  
  def self.run
    transaction {
      FreeDoll.run
      User.run
      instance.run
    }
  end
end
