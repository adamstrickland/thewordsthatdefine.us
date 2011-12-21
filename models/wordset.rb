class Wordset
	attr_accessor :words, :context, :owner

	def initialize(opts = {})
		words = opts[:words] || []
		context ||= opts[:context]
		owner ||= opts[:owner]
	end

	def save
		wordmodels = self.words.map do |w|
			Word.new(:name => w, :context => context, :owner => owner)
		end
		wordmodels.each do |w| 
			w.save
		end
	end
end