class Product
	include MongoMapper::Document

	key :name, String
	key :description, String

	many :ratings, :dependent => :destroy
	many :opinions, :dependent => :destroy

	key :category_ids, Array
    many :categories, :in => :category_ids

	validates_presence_of :name, :description

    def average_rating
		if self.ratings.size == 1
			0.0
		else
			total = 0.0
			self.ratings.each do |r|
				if r.score > 0.0
		            total += r.score
		        end
		    end
    		total / (self.ratings.size - 1)
    	end
	end
end