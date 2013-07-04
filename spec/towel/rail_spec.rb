# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/towel/rail'

describe Towel::Rail do

  before do
    @controller = ThingsController.new
    @rail = Towel::Rail.new(@controller)
  end

  it 'should create an index method' do
    @controller.expects(:respond_with).with(Thing.all)
    @controller.index
  end
end
