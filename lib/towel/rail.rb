# encoding: UTF-8

module Towel
  class Rail
    def initialize(controller, options={})
      @controller = controller
      @options = options
      @resource = Resource.new(@controller, options)
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
      create_method(:index) do
        respond_with(@resource.collection)
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
