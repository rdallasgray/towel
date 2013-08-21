# encoding: UTF-8

require_relative '../spec_helper'

describe Towel::Rail do

  before do
    @controller = ThingsController.new
    @controller.extend(Towel::ResourceHelpers)
    @rail = Towel::Rail.new(@controller)
  end

  it 'should create an index method' do
    @controller.expects(:respond_with).with(Thing.all)
    @controller.index
  end
end
