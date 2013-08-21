# encoding: UTF-8

require 'active_support/core_ext/string'

module Towel
  module ResourceHelpers
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

    def create_resource(attributes)
      collection_source.create(attributes)
    end

    def resource_collection
      collection_source.all
    end

    def single_resource
      resource_class.find(params[:id])
    end

    def parent?
      !parent_resource.nil?
    end

    def parent_resource
      @parent_resource ||= get_parent_resource
    end

    private

    def collection_source
      parent? ? parent_resource.send(collection_symbol) : resource_class
    end

    def get_resource_class
      class_name = controller_name.classify
      Kernel.const_get(class_name)
    end

    def get_parent_resource
      foreign_keys = params.keys.select do |k|
        resource_params = params[resource_symbol]
        /^\w+_id$/ =~ k && (resource_params.nil? || !resource_params.include?(k))
      end
      return nil if foreign_keys.empty?
      parent_key = foreign_keys.first
      parent_id = params[parent_key]
      class_name = parent_key[0..-4].classify
      Kernel.const_get(class_name).find(parent_id)
    end
  end
end
