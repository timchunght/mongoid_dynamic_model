require "spec_helper"
require "mongoid_dynamic_model"
describe Mongoid::DynamicModel do

  it "creates a CustomModel" do
    Mongoid::DynamicModel.new_model("CustomModel")
    CustomModel.create(name: "first_custom_model")
    custom_model = CustomModel.first
    expect(custom_model.name).to eq "first_custom_model"
    remove_objects(CustomModel)
  end

  it "lists collections in the current configured database (connection testing)" do
  	# db = Mongoid.default_client.database
		# puts db.collection_names.join(",")
		tables = Mongoid::DynamicModel.list_collections
		puts tables
	end

	it "removes all collections" do
		remove_collections
	end

	it "raises error when dropping a non-existent collection" do
		expect{Mongoid::DynamicModel.drop_collection("non_existent_models")}.to raise_error("Collection non_existent_models not found")

	end

	xit "creates a model based on the collection" do
		Mongoid::DynamicModel.new_model("CustomModel")
	end
end
