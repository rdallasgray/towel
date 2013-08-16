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
    { id: 1, parent_id: 1, thing: { id: 1 } }
  end
end

class Thing
  attr_accessor :parent

  def self.all
    @all ||= [Thing.new, Thing.new]
  end

  def self.find(id)
    @one ||= Thing.new
  end
end

class Parent
  def self.find(id)
    @one ||= Parent.new
  end

  def self.all
    @all ||= [Parent.new]
  end

  def things
    @things ||=
      begin
        all = Thing.all
        all.each { |thing| thing.parent = self }
        class << all
          def all
            self
          end
          def create(attributes)
          end
        end
      end
  end
end
