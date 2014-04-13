class Opinion
	include MongoMapper::EmbeddedDocument

	key :login, String
	key :text, String
	timestamps!

    validates_presence_of :login, :text
end