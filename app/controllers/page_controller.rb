class PageController < ApplicationController
	def home
		 @posts = Post.most_recent.where(status: "Published")
    
    respond_to do |format|
      format.html
      format.json{ render json: Post.all }
      end
	end
		
	#def home
	#	@posts = Post.joins(:tags).where('tags.name = ?', 'test').where(status: "Published")#.merge('categories.id = ?', 2)
	#end	
end