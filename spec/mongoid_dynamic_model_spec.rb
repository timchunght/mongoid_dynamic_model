require "spec_helper"
require "mongoid_dynamic_model"
describe Mongoid::DynamicModel do

  it "creates a CustomModel" do
    Mongoid::DynamicModel.new_model("CustomModel", {name: "name", type: "String"})
    CustomModel.create(name: "first_custom_model")
    custom_model = CustomModel.first
    expect(custom_model.name).to eq "first_custom_model"
    remove_objects(CustomModel)
  end

  it "lists collections in the current configured database (connection testing)" do
		tables = Mongoid::DynamicModel.list_collections
		puts tables
	end

	# it "connect to db by specifying db" do
	# 	db_setting = {host: "localhost", port: "27017", database: "new_database"}
 #    tables = Mongoid::DynamicModel.list_collections(db_setting)
 #    puts tables
 #  end

	it "removes all collections" do
		remove_collections
	end

	it "raises error when dropping a non-existent collection" do
		expect{Mongoid::DynamicModel.drop_collection("non_existent_models")}.to raise_error("Collection non_existent_models not found")

	end

	it "raises no class error when inserting a field a non-existent model" do
		Mongoid::DynamicModel.new_model("HelloModel")
		Mongoid::DynamicModel.insert_field("HelloModel", {name: "email", type: "String"})
		HelloModel.create
	end

	it "creates models with specified type" do
		Mongoid::DynamicModel.load("./lib/models.rb")
		expect(Person.fields["name"].type).to eq String
	end

	xit "creates a model based on the collection" do
		Mongoid::DynamicModel.new_model("CustomModel")
	end
end
