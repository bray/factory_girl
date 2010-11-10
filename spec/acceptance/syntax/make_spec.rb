require 'spec_helper'

require 'factory_girl/syntax/make'

describe "a factory using make syntax" do
  before do
    Factory.define :user do |factory|
      factory.first_name 'Bill'
      factory.last_name  'Nye'
      factory.email      'science@guys.net'
    end
  end

  after do
    Factory.factories.clear
  end

  it "should get its factory attributes" do
    User.factory_attrs.should == {:first_name => 'Bill', :last_name => 'Nye', :email => 'science@guys.net'}
  end

  describe "after making an instance" do
    before do
      @instance = User.make(:last_name => 'Rye')
    end

    it "should use attributes from the factory" do
      @instance.first_name.should == 'Bill'
    end

    it "should use attributes passed to make" do
      @instance.last_name.should == 'Rye'
    end

    it "should not save the record" do
      @instance.should be_new_record
    end
  end

  describe "after making and saving an instance" do
    before do
      @instance = User.make!(:last_name => 'Rye')
    end

    it "should use attributes from the factory" do
      @instance.first_name.should == 'Bill'
    end

    it "should use attributes passed to make" do
      @instance.last_name.should == 'Rye'
    end

    it "should save the record" do
      @instance.should_not be_new_record
    end
  end
end
