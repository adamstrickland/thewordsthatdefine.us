class Wordset
	attr_accessor :words

	def initialize(word_string_or_array, opts={})
		# word_array = if word_string_or_array.respond_to?(:split)
		word_array = if word_string_or_array.kind_of?(String)
			word_string_or_array.split(/,\s*/)
		else
			word_string_or_array
		end
		self.words = word_array.map do |w|
			Word.new(name: w, context: opts[:context], owner: opts[:owner])
		end
	end

	def save
		self.words.map{|w| w.save }.all?
	end
end