
def user() User.first end
def dolls() user.dolls end

def login
  "logged: user:#{user.id}"
end

def free_dolls
  FreeDoll.all
end

def choice(free_doll_id)
  user.choice free_doll_id
end

# d0..d6
7.times {|i| eval("def d#{i}() user.dolls[#{i}] end") }

# -- debug

def setup
  User.find_or_create_by_id(1)
  login
end

def run
  World.run
end

def reload
  reload!
  load __FILE__
  login if u
  'reload.'
end

def server
end

alias :u :user
alias :d :dolls
alias :r :run
alias :f :free_dolls
alias :c :choice
alias :re :reload

class Array
  def inspect
    if first.is_a?(Doll)
      "Dolls[\n" + self.map(&:simple_inspect).join(",\n") + "\n]"
    else
      super
    end
  end
end

# -- test

def test
  login
  d
  d1
end
