class User < ActiveRecord::Base
  has_many :dolls
  has_many :items
  belongs_to :town

  def choice(free_doll_id)
    free = FreeDoll.find(free_doll_id)
    free.destroy
    dolls.create :seed => free.seed
  end

  def run
    leader_dolls = dolls.select {|e| !e.doll }
    r = leader_dolls.map(&:run)
    save!
    r
  end

  def self.run
    all.map &:run
  end
end
