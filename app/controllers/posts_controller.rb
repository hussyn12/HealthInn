class PostsController < ApplicationController

  def index
    @posts = Post.most_recent.where(status: "Published")
    
    respond_to do |format|
      format.html
      format.json{ render json: Post.all }
      end
  end

def show
  @posts = Post.most_recent.where(status: "Published")
  @post = Post.friendly.find(params[:id])
  @tags = Tag.all
  impressionist(@post)
  respond_to do |format|
    format.html
    format.json {render :json => @post, :callback => params[:callback], mime_type: Mime::Type.lookup("application/json")}
  end
end


end
