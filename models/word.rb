class Word
	include Mongoid::Document
	field :name, type: String
	field :context, type: String
	field :owner, type: String, default: "anonymous"
	field :created_at, type: DateTime, default: -> { Time.now }

	validates_presence_of :name
end