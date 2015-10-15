#Mongoid Dynamic Model

	load './mongoid_dynamic_model.rb'
	Mongoid::DynamicModel.new_model("CustomModel")

Check ``models.rb`` for basic configuration
To load a models.rb file, do

	Mongoid::DynamicModel.load('models.rb')

Dependency:

Mongoid

TODOS:
---
This script is extremely early stage, it should be packaged into a gem

##Credit:
Timothy Chung
The core of the script is heavily borrowed from an abandoned project created 4 years ago called ``mongoid_model_builder``

