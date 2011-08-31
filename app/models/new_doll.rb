class NewDoll < ActiveRecord::Base
  after_create {
    seed = id
    save
  }

  def self.run
    create while count < 5
    all
  end
end
