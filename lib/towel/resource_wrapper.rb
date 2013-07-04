# encoding: UTF-8

module Towel
  class ResourceWrapper
    def initialize(controller, options)
      @controller = controller
      @options = options
    end

    def resource_class
      @resource_class ||= get_resource_class
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

    def parent_resource
      @parent_resource ||= get_parent_resource
    end

    private

    def get_resource_class
      class_name = @controller.controller_name.classify
      Kernel.const_get(class_name)
    end

    def get_parent_resource
      foreign_keys = @controller.params.keys.select do |k|
        resource_params = @controller.params[resource_symbol]
        /^\w+_id$/ =~ k && (resource_params.nil? || !resource_params.include?(k))
      end
      return nil if foreign_keys.empty?
      parent_key = foreign_keys.first
      parent_id = @controller.params[parent_key]
      class_name = parent_key[0..-4].classify
      Kernel.const_get(class_name).find(parent_id)
    end
  end
end
