require "json"
module Mongoid
  module DynamicModel
    class << self
      # Load models definitions from Ruby configuration Array or file.
      def load models, options = {}

        # Try to read file if a String is provided
        models = eval File.read models if models.is_a? String

        raise "Models list must be an Array or a ruby file containing an Array" unless models.is_a? Array

        result = []
        @code  = []
        models.each do |model|
          result << build(model, options[:force])
        end

        return @code.join("\n") if options[:code]
        return result
      end

      def new_model model, fields = [], options = {}

        if fields.class == Hash && !fields.blank?
          fields = [fields]
        end

        model = {
          :name => model,
          :fields => fields
        }  
        @code  = []
        result = build(model, options[:force])
        # Return the code that generates the model
        # if options[:code] == true
        if options[:code]
          return @code.join("\n") 
        else
          return result
        end
      end

      def insert_field(model, field)
        if Object.const_defined? model
          
          [:type, :name].each do |key|
            if field.has_key?(key) && !field[key].empty? && !field[key].nil?
            else
              raise "#{key} and value must be present"
            end
          end
          @model = model.constantize
          add_field field
          
        else
          raise NameError, "uninitialized model #{model}"
        end
      end

      def insert_fields(model, fields)
      end

      def list_collections(setting = {})
        db_connect(setting).collection_names
      end

      def drop_collections(setting = {})
        db_connect(setting).collections.each do |col|
          col.drop
        end
      end

      def drop_collection(name, setting = {})
        if list_collections.include?(name)
          db_connect(setting)[name].drop
        else
          raise "Collection #{name} not found"
        end
      end

      private

      # Build a model class
      def build model, force
        # Handle existing classes
        if Object.const_defined? model[:name]
          raise "Class '#{model[:name]}' already exists." unless force
          Object.send(:remove_const, model[:name]) rescue nil
        end

        # Set parent class
        parent = model[:extends] ? model[:extends].constantize : Object

        # Create model class
        @model = Object.const_set model[:name], Class.new(parent)
        @code << "class #{model[:name]} < #{parent}"

        # Include Mongoid::Document by default
        includes = %w(Mongoid::Document)
        if model[:includes]
          raise "Includes list must be an Array (#{model[:includes].class} provided)" unless model[:includes].is_a? Array
          includes |= model[:includes]
        end

        add_includes includes
        add_fields model[:fields]

        @code << 'end'

        return @model
      end

      # Appends code to current model class
      def model_append source
        source = source.join("\n") if source.is_a? Array
        raise "model_append only accepts String or Array source (#{source.class} provided)" unless source.is_a? String
        @model.class_eval source
        @code << source
      end

      # Adds class includes to current model class
      def add_includes includes
        a = []
        includes.uniq.each do |value|
          a << "include #{value.constantize}"
        end
        model_append a
      end

      # Adds fields to current model class
      def add_fields fields
        raise "Fields list must be an Array (#{fields.class} provided)" unless fields.is_a? Array

        fields.each do |field|
          add_field field
        end
      end
      
      # Add field to current model class
      def add_field field
        raise "Field must be a Hash (#{field.class} provided)" unless field.is_a? Hash

        
        # Retrieve parent field options if not overloaded
        if @model.superclass.respond_to?('fields') && @model.superclass.fields.has_key?(field[:name])
          parent = @model.superclass.fields[field[:name]]
          field[:type]     = parent.type        unless field[:type]
          field[:default]  = parent.default_val unless field[:default]
          field[:label]    = parent.label       unless field[:label]
          field[:localize] = parent.localized?  unless field[:localize]
        end
        # puts field.to_json

        new_model_options = ""
        
        if field.has_key?(:name) && !field[:name].empty? && !field[:name].nil?   
            new_model_options = "field :#{field[:name]}"
        else
            raise "name and its value must be present"
        end

        # Field definition
        allowed_options = [:type, :default, :localize, :label]
        allowed_options.map do |option|
          # option = option.to_s
          if field[option]
            new_model_options += ", #{option.to_s}: #{field[option]}"
          end
        end
        model_append new_model_options
        # puts new_model_options
        # Length option automatically creates a maximum length validator
        field = {:validators => {:length => {:maximum => field[:length]}}}.deep_merge(field) if field[:length]
        add_validators field
      end

      # Add validators to model class
      def add_validators field
        return unless field[:validators]
        raise "Field validators list must be a Hash (#{field[:validators].class} provided)" unless field[:validators].is_a? Hash

        model_append "validates :#{field[:name]}, #{field[:validators]}"
      end

      def db_connect setting = {}
        if setting.empty?
          Mongoid.default_client.database
        else
          Mongo::Client.new([ "#{setting[:host]}:#{setting[:port]}" ], :database => "#{setting[:database]}").database
        end
      end
    end
  end
end