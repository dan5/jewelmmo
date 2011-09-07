# -*- encoding: utf-8 -*-
require 'spec_helper'

describe User do
  before do
    @user = User.create
  end

  it { @user.dolls.should be_empty }

  describe "free dollをchoiceしたとき" do
    before do
      free_doll = FreeDoll.create
      @user.choice free_doll.id
    end

    it { FreeDoll.count.should == 0 }
    it { @user.dolls.size.should == 1 }
  end
end
