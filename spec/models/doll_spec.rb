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

  subject { @doll }

  its(:leader?) { should be_true }

  it "自分をfollowすると例外" do
    proc { @doll.follow @doll }.should raise_error(RuntimeError, "it's you!")
  end

  context "dollをfollowしたとき" do
    before do
      @doll.follow @dolls[1]
    end

    its(:leader?) { should be_false }

    it "followされると例外" do
      # todo: "is'nt"
      proc { @dolls[2].follow @doll }.should raise_error(RuntimeError, "isn't a leader!")
    end
  end

  context "dollにfollowされたとき" do
    before do
      @leader = @doll
      @dolls[1].follow @doll
    end

    subject { @leader }

    its(:leader?) { should be_true }

    it "memberは2人" do
      @leader.members.size.should == 2
    end

    it "unfollowされてもリーダー" do
      @dolls[1].unfollow
      @leader.leader?.should be_true
    end

    it "リーダーがdollをfollowすると例外" do
      proc { @leader.follow @dolls[2] }.should raise_error(RuntimeError, "you is a leader!")
    end
  end

  context "#strength" do
    before do
      @dolls.each_with_index {|e, i| e.str = i + 1 }
    end

    its(:strength) { should == 1 }

    context "3人パーティのとき" do
      before do
        @dolls[1].follow @doll
        @dolls[2].follow @doll
      end

      its(:strength) { should == 6 }

      it { @doll.members.size.should == 3 }

      context "ひとり抜けると..." do
        before do
          @dolls[2].unfollow
        end

        its(:strength) { should == 3 }
        it { @doll.members.size.should == 2 }
      end
    end
  end

  context "actionがないとき" do
    before { @doll.update_attribute :action, nil }

    context "dollをfollowしたとき" do
      before { @doll.follow @dolls[1] }

      it "#startすると例外" do
        proc { @doll.start }.should raise_error
      end

      it "#stopすると例外" do
        proc { @doll.stop }.should raise_error
      end
    end

    context "#startを実行したとき" do
      before { @doll.start }

      its(:action) { should == 'explore' }

      it "#sleepすると例外" do
        proc { @doll.sleep }.should raise_error
      end

      context "#stop" do
        before { @doll.stop }
        its(:action) { be_false }
      end
    end

    context "#sleepを実行したとき" do
      before { @doll.sleep }

      its(:action) { should == 'sleep' }

      context "#start" do
        before { @doll.start }
        its(:action) { should == 'explore' }
      end
    end
  end

  context "hp1でsleepしたとき" do
    before do
      @doll.update_attribute :hp, 1
      @doll.sleep
    end

    subject { @doll }

    its(:hp) do
      @doll.run
      should == 2
    end

    (1..10).each do |i|
      its(:hp) do
        @doll.stub!(:rand).and_return(0)
        i.times { @doll.run }
        if i + 1 < @doll.maxhp
          should == i + 1
        else
          should == 7
        end
      end
    end

    (2..7).each do |i|
      its(:hp) do
        @doll.stub!(:rand).and_return(1)
        i.times { @doll.run }
        should == 1
      end
    end
  end
end
