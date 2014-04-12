class Rating
    include MongoMapper::Document

	key :score, Integer, :default => 0
	key :hash, String

    belongs_to :product
end