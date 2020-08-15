class Admin::CategoriesController < Admin::ApplicationController
  def new
    @category = Category.new
    @categories = Category.all.order(id: :desc)
  end

  def create
    @categories = Category.new(categories_params).save

  
   redirect_to new_admin_category_url, notice: 'Category is Successfully created'
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update categories_params
      redirect_to new_admin_category_url, notice: 'Successfully Updated'
    else
     flash[:alert] = 'There is a Problem in Updating this Tag'
     render :edit
    end   
  end

  def show
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to :back, notice: 'Successfully Deleted'
  end
  private

  def categories_params
    params.require(:category).permit(:id, :name)
  end  
end
