class Article < ActiveRecord::Base
	attr_accessible :title, :body, :image
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings
	attr_accessible :tag_list
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	attr_accessible :image
	
	def tag_list
		self.tags.collect do |tag|
			tag.name
		end.join(", ")
	end

	def to_s
		name
	end

	def tag_list=(tags_string)
		self.taggings.destroy_all

  		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq

  		tag_names.each do |tag_name|
    		tag = Tag.find_or_create_by_name(tag_name)
    		tagging = self.taggings.new
    		tagging.tag_id = tag.id
  		end
	end
end
