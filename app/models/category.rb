class Category
	include MongoMapper::Document

	key :name, String

    key :product_ids, Array
    many :products, :in => :product_ids

	validates_presence_of :name
end