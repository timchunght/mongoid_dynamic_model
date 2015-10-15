Install Gem:

#Mongoid Dynamic Model

	gem build *.gemspec
	gem install *.gem
	irb
	require 'mongoid_dynamic_model'

Establish a connection to MongoDB first if you are not running in a Rails Environment (check out the ``Access Mong Client via irb`` section):

	Mongoid::DynamicModel.new_model("CustomModel")

###Access Mongo Client via irb:

	Mongoid.configure do |config|
	  config.connect_to('your_db_name')
	end

Unlike Relational database, you don't need to run migration or create the database. Currently, mongoid assumes ``localhost:27017``

Now require the necessary model/class to access the collection, or if you are in Rails, your models will be loaded automatically.

For multi-model schema configuration, check ``models.rb`` for basic configuration. To load a ``models.rb`` file, in console, do

	Mongoid::DynamicModel.load('your_path/models.rb')

###Sample Mongoid class:

	class Book
		 include Mongoid::Document
		 field :name, type: String
	end

Dependency:
---
Mongoid

TODOS:
---
This script is extremely early stage, it should be packaged into a gem

##Credit:
Timothy Chung

The core of the script is heavily borrowed from an abandoned project created 4 years ago called ``mongoid_model_builder``. I really appreciate the author's original approach, which was almost identical to my initial hacky script. I hope this rewrite/revamp will make this project useful to more people.

