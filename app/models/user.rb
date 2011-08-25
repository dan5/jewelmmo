class User < ActiveRecord::Base
  has_many :dolls
  has_many :items
  belongs_to :town

def test_setup
  user = User.create
  doll = user.dolls.create(:str => 7)
  Array.new(5) {|i| doll.dolls.create :user => user, :str => 6 - i }

  assert doll.events.count == 0
  doll.events.create :name => :encount
  assert doll.events.count == 1
  doll.open
  doll.reload
  assert doll.events.count == 1

  p doll.members.map(&:id)
  p doll.members.map(&:hp)
end

def assert(flag, message = "error")
  flag or raise message
end

end
