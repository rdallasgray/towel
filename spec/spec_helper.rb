# encoding: UTF-8

require 'minitest/autorun'
require 'mocha/setup'

class ThingsController
  def controller_name
    'things'
  end

  def respond_with(resource)
  end

  def params
    { id: 1 }
  end
end

class Thing
  def self.all
    @all ||= [self.class.new, self.class.new]
  end

  def self.find(id)
    @one ||= self.class.new
  end
end
