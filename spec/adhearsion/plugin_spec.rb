require 'spec_helper'

include InitializerStubs

# If you have a Gemfile, require the gems listed there, including any gems
# This is done by config/environment.rb in a real app

describe Adhearsion::Plugin do

  describe "inheritance" do

    after(:each) do
      defined?(FooBar) and Object.send(:remove_const, :"FooBar")
    end

    it "should provide the plugin name in a plugin class" do
      ::FooBar = Class.new Adhearsion::Plugin
      ::FooBar.plugin_name.should eql("foo_bar")
    end

    it "should provide the plugin name in a plugin instance" do
      ::FooBar = Class.new Adhearsion::Plugin
      ::FooBar.new.plugin_name.should eql("foo_bar")
    end

    it "should provide a setter for plugin name" do

      ::FooBar = Class.new Adhearsion::Plugin do
        self.plugin_name = "bar_foo"
      end

      ::FooBar.plugin_name.should eql("bar_foo")
    end

    it "should provide access to a config mechanism" do
      FooBar = Class.new Adhearsion::Plugin
      FooBar.config.should be_kind_of(Adhearsion::Plugin::Configuration)
    end

    it "should provide a config empty variable" do
      FooBar = Class.new Adhearsion::Plugin
      FooBar.config.length.should be(0)
    end

    it "should allow to set a new config value" do
      FooBar = Class.new Adhearsion::Plugin do
        config.foo = "bar"
      end
      FooBar.config.foo.should eql("bar")
    end

    it "should allow to get a config value using []" do
      FooBar = Class.new Adhearsion::Plugin do
        config.foo = "bar"
      end
      FooBar.config[:foo].should eql("bar")
    end

    it "should allow to set a config value using [:name] = value" do
      FooBar = Class.new Adhearsion::Plugin do
        config[:foo] = "bar"
      end
      FooBar.config.foo.should eql("bar")
      FooBar.config.length.should eql(1)
    end
  end

  describe "add and delete on the air" do
    it "should add plugins on the air" do
      Adhearsion::Plugin.delete_all
      Adhearsion::Plugin.add(AhnPluginDemo)
      Adhearsion::Plugin.count.should eql(1)
    end

    it "should delete plugins on the air" do
      Adhearsion::Plugin.delete_all
      Adhearsion::Plugin.add(AhnPluginDemo)
      Adhearsion::Plugin.count.should eql(1)
      Adhearsion::Plugin.delete(AhnPluginDemo)
      Adhearsion::Plugin.count.should eql(0)
    end

  end

  describe "Adhearsion::Plugin.count" do

    after(:each) do
      defined?(FooBar) and Object.send(:remove_const, :"FooBar")
    end
  
    it "should count the number of registered plugins" do
      number = Adhearsion::Plugin.count
      FooBar = Class.new Adhearsion::Plugin
      Adhearsion::Plugin.count.should eql(number + 1)
    end

  end

end

describe "Adhearsion::Plugin.load" do
  
  before(:each) do
    Adhearsion::Plugin.send(:subclasses=, nil)
    Adhearsion::Plugin.send(:dialplan_methods=, {})
  end

  let(:o) do
    o = Object.new
    o.class.send(:define_method, :load_code) do |code|
    end
  end

  let(:dialplan_module) do
    Module.new
  end

  after(:each) do
    defined?(FooBar) and Object.send(:remove_const, :"FooBar")
  end

  describe "Plugin subclass with no dialplan definition" do

    it "should initialize all Plugin childs" do
      FooBar = Class.new Adhearsion::Plugin
      flexmock(FooBar).should_receive(:init).once
      Adhearsion::Plugin.load
    end

    it "should initialize all Plugin childs, including deep childs" do
      FooBar = Class.new Adhearsion::Plugin
      FooBarBaz = Class.new FooBar
      FooBarBazz = Class.new FooBarBaz

      flexmock(FooBar).should_receive(:init).once
      flexmock(FooBarBaz).should_receive(:init).once
      flexmock(FooBarBazz).should_receive(:init).once
      Adhearsion::Plugin.load
    end
  end
  
  describe "Plugin subclass with dialplan_method definition" do
    it "should add a method defined using dialplan" do
      FooBar = Class.new Adhearsion::Plugin do
        dialplan :foo
        def self.foo(call)
          "bar"
        end
      end
      
      flexmock(FooBar).should_receive(:init).once
      flexmock(Adhearsion::Plugin).should_receive(:dialplan_module).once.and_return(dialplan_module)
      Adhearsion::Plugin.load
      dialplan_module.instance_methods.include?(:foo).should be true
    end

    it "should add an array of methods defined using dialplan_method" do
      FooBar = Class.new Adhearsion::Plugin do
        dialplan [:foo, :bar]

        def self.foo(call)
          call
        end

        def self.bar(call)
          "foo"
        end
      end
      
      flexmock(FooBar).should_receive(:init).once
      flexmock(Adhearsion::Plugin).should_receive(:dialplan_module).twice.and_return(dialplan_module)
      Adhearsion::Plugin.load
      [:foo, :bar].each do |method|
        dialplan_module.instance_methods.include?(method).should be true
      end
    end

    it "should add a method defined using dialplan with a specific block" do
      FooBar = Class.new Adhearsion::Plugin do
        dialplan :foo do |call|
          puts call
        end
      end
      
      flexmock(FooBar).should_receive(:init).once
      flexmock(Adhearsion::Plugin).should_receive(:dialplan_module).once.and_return(dialplan_module)
      Adhearsion::Plugin.load
      dialplan_module.instance_methods.include?(:foo).should be true
    end
  end
  
  
end

describe "Initializing Adhearsion" do
  it "should load the new dial plans" do
    flexmock(Adhearsion::Initializer::Logging).should_receive(:start).once.and_return('')
    flexmock(::Logging::Appenders::File).should_receive(:assert_valid_logfile).and_return(true)
    flexmock(::Logging::Appenders).should_receive(:file).and_return(nil)

    #say_hello = AhnPluginDemo::SayText.new("value")
    #flexmock(say_hello).should_receive(:start).once.and_return(true)
    #flexmock(AhnPluginDemo).should_receive(:create_say_text).once.and_return(say_hello)

    stub_behavior_for_initializer_with_no_path_changing_behavior do
      ahn = Adhearsion::Initializer.start "/path"
    end
  end
end
