class Word
	include Mongoid::Document
	field :name
	field :context
	field :owner
end