require "spec_helper"
require "mongoid_dynamic_model"
describe Mongoid::DynamicModel do

  it "creates a CustomModel" do
    Mongoid::DynamicModel.new_model("CustomModel")
    CustomModel.create(name: "first_custom_model")
    custom_model = CustomModel.first
    expect(custom_model.name).to eq "first_custom_model"
  end
end
