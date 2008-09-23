ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require "spec"
require "spec/rails"
require "ruby-debug"

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ":memory:"}}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["test"])

load(File.dirname(__FILE__) + '/schema.rb')

Spec::Runner.configure do |config|
end

class Object
  def self.unset_class(*args)
    class_eval do 
      args.each do |klass|
        eval(klass) rescue nil
        remove_const(klass) if const_defined?(klass)
      end
    end
  end
end

alias :doing :lambda