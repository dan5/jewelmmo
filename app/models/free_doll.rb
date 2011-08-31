class FreeDoll < ActiveRecord::Base
  after_create { update_attribute :seed, id }

  def self.run
    create while count < 5
    all
  end
end
