# encoding: UTF-8

module Towel
  class ResourceWrapper
    def initialize(controller, options)
      @controller = controller
      @options = options
    end

    def resource_class
      @resource_class ||=
        begin
          class_name = @controller.controller_name.classify
          Kernel.const_get(class_name)
        end
    end

    def resource_symbol
      @resource_symbol ||= resource_class.name.downcase.to_sym
    end

    def collection_symbol
      @collection_symbol ||= resource_symbol.to_s.pluralize.to_sym
    end

    def new_resource
      resource_class.new
    end

    def resource_collection
      resource_class.all
    end

    def single_resource
      resource_class.find(@controller.params[:id])
    end
  end
end
