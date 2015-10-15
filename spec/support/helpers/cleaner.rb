def remove_objects(model)
	count = model.all.size
	model.destroy_all
	puts "Cleaned #{count} #{model.to_s} object(s)"
end

def remove_collections
	Mongoid.default_client.database.collections.each do |col|
		col.drop
	end
end