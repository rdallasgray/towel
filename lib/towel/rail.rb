# encoding: UTF-8

require_relative 'resource_wrapper'

module Towel
  class Rail
    def initialize(controller, options={})
      @test = 'test'
      @controller = controller
      @options = options
      @resource_wrapper = ResourceWrapper.new(@controller, options)
      create_actions
    end

    private

    def create_actions
      option(:actions).each { |a| send("create_#{a}") }
    end

    def create_method(name, &body)
      singleton_class = class << @controller; self; end
      singleton_class.send(:define_method, name, &body)
    end

    def create_index
      rw = @resource_wrapper
      create_method(:index) do
        respond_with(rw.resource_collection)
      end
    end

    def create_show
    end

    def create_new
    end

    def create_create
    end

    def create_update
    end

    def create_delete
    end

    def defaults
      { actions: %w{ index show new create update delete } }
    end

    def option(key)
      @options[key] || defaults[key]
    end
  end
end
