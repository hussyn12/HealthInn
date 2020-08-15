class Category < ActiveRecord::Base
	has_many :posts, through: :post_categories
	validates :name, presence: true

	def in_use?
		PostCategory.exists?(category_id: self.id)

	end	
end
