
def user() @user end
def dolls() user.dolls end

def login
  @user = User.first
  "logged: user:#{user.id}"
end

def newdolls
  NewDoll.all
end

# d0..d6
7.times {|i| eval("def d#{i}() user.dolls[#{i}] end") }

def run
  :hello
  #User.all.each(&:runr)
end

# -- debug

def setup
  User.find_or_create_by_id(1)
  login
end

def reload
  reload!
  load __FILE__
  login if u
  'reload.'
end

alias :u :user
alias :d :dolls
alias :r :run
alias :re :reload

# -- test

def test
  login
  d
  d1
end