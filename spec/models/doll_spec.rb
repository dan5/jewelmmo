# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Doll do
  before do
    user = User.create
    3.times do
      free_doll = FreeDoll.create
      user.choice free_doll.id
    end
    @dolls = user.dolls
    @doll = @dolls.first
  end

  it "まずdollはリーダーである" do
    @doll.leader?.should be_true
  end

  describe Doll do
    before do
      @doll.follow @dolls[1]
    end

    it "dollはリーダーではない" do
      @doll.leader?.should be_false
    end
  end

  describe Doll do
    before do
      @dolls[1].follow @doll
    end

    it "dollはリーダーである" do
      @doll.leader?.should be_true
    end
  end
end
