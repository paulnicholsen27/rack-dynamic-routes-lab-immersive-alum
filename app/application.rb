class Application

	def call(env)
		resp = Rack::Response.new
		req = Rack::Request.new(env)

		if req.path.match(/items/)
			item_name = req.path.split(/\//).last
			puts item_name
			desired_item = nil
			@@items.each do |item|
				if item.name.downcase == item_name.downcase
					desired_item = item
				end
			end
			if desired_item
				resp.write(desired_item.price)
			else
				resp.write "Item not found"
				resp.status = 400
			end
		else
			resp.write "Route not found"
			resp.status = 404
		end
		resp.finish
	end
end
