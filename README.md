#Mongoid Dynamic Model

	load './mongoid_dynamic_model.rb'
	Mongoid::DynamicModel.new_model("CustomModel")

Check ``models.rb`` for basic configuration
To load a models.rb file, do

	Mongoid::DynamicModel.load('models.rb')


###Access Mongo Client via irb:

	Mongoid.configure do |config|
	  config.connect_to('mongoid_dynamic_model_test')
	end

And require the necessary model/class to access the collection

###Sample Mongoid class:

	class Book
		 include Mongoid::Document
		 field :name, type: String
	end

Dependency:

Mongoid

TODOS:
---
This script is extremely early stage, it should be packaged into a gem

##Credit:
Timothy Chung
The core of the script is heavily borrowed from an abandoned project created 4 years ago called ``mongoid_model_builder``

