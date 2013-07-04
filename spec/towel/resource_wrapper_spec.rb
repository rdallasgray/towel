# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/towel/resource_wrapper'
require 'active_support/core_ext/string'

describe Towel::ResourceWrapper do

  before do
    @controller = ThingsController.new
    @wrapper = Towel::ResourceWrapper.new(@controller, {})
  end

  it 'should get a resource symbol' do
    @wrapper.resource_symbol.must_equal :thing
  end

  it 'should get a collection symbol' do
    @wrapper.collection_symbol.must_equal :things
  end

  it 'should get a new resource' do
    @wrapper.new_resource.must_be_instance_of Thing
  end

  it 'should get a collection' do
    @wrapper.resource_collection.must_be_same_as Thing.all
  end

  it 'should get a single resource' do
    id = @controller.params[:id]
    @wrapper.single_resource.must_be_same_as Thing.find(id)
  end

  it 'should get a parent resource' do
    wrapper = Towel::ResourceWrapper.new(@controller, { parent: true })
    wrapper.parent_resource.must_be_instance_of Parent
  end
end
