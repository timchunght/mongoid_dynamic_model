def remove_objects(model)
	count = model.all.size
	model.destroy_all
	puts "Cleaned #{count} #{model.to_s} object(s)"
end