class User < ActiveRecord::Base
  has_many :dolls
  has_many :items
  belongs_to :town

  def run
    leader_dolls = dolls.select {|e| !e.doll }
    User.transaction {
      r = leader_dolls.map(&:run)
      save!
      r
    }
  end
end
