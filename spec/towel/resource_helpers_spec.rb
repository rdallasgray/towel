# encoding: UTF-8

require_relative '../spec_helper'

describe Towel::ResourceHelpers do

  before do
    @controller = ThingsController.new
    @controller.extend(Towel::ResourceHelpers)
  end

  it 'should get a resource symbol' do
    @controller.resource_symbol.must_equal :thing
  end

  it 'should get a collection symbol' do
    @controller.collection_symbol.must_equal :things
  end

  it 'should get a new resource' do
    @controller.new_resource.must_be_instance_of Thing
  end

  it 'should get a collection' do
    @controller.resource_collection.must_be_same_as Thing.all
  end

  it 'should get a single resource' do
    id = @controller.params[:id]
    @controller.single_resource.must_be_same_as Thing.find(id)
  end

  it 'should create a resource' do
    attrs = { test: 1 }
    Thing.expects(:create).with(attrs)
    @controller.create_resource(attrs)
  end

  it 'should get a parent resource' do
    params = @controller.params
    params_with_parent = params.merge({ parent_id: 1 })
    @controller.stub :params, params_with_parent do
      @controller.parent_resource.must_be_instance_of Parent
    end
  end

  it 'should get a collection from a parent resource' do
    params = @controller.params
    params_with_parent = params.merge({ parent_id: 1 })
    @controller.stub :params, params_with_parent do
      collection = @controller.resource_collection
      collection.first.parent.must_equal controller.parent_resource
    end
  end
end
