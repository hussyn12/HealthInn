class Admin::PostsController < Admin::ApplicationController
  def index
     
    @posts = Post.matching_title_or_content(params[:search]).variable_for(params[:tag]).by_category(params[:cat]).page params[:page]
  end 

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.moderator_id = current_moderator.id
     respond_to do |format|
      if @post.save
      format.html { redirect_to admin_posts_url, notice: 'Post is Successfully created' }
       format.json { render :show, status: :created, location: @post }
      else
       flash[:alert] = 'There is a problem creating post'
       format.html { render :new }
       format.json { render json: @post.errors, status: :unprocessable_entity  }
     end 
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    respond_to do |format|
    if @post.update(post_params)
      format.html do
      redirect_to admin_posts_url, notice: 'Post was Successfully Updated'
    end
      format.json { render :show, status: :ok, location: @post }
    else 
      flash[:alert] = 'There is a Problem Updating Post'
      render :edit
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end 
    end 
  end

  def show
    @post =Post.friendly.find(params[:id])
  end

  def destroy
     @posts = Post.friendly.find(params[:id])
     @posts.destroy
     
      redirect_to :back, notice: 'Post was Successfully Deleted'
  end


  private

  def post_params
     params.require(:post).permit(:id, :title, :description, :content, :published_at, :status, :banner_image_url, :image, :tag_list, category_ids: [] )
  end
end