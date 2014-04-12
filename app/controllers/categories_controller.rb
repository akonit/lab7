class CategoriesController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin"

	def new
		@category = Category.new
    end

    def create
    	@category = Category.new(category_params)
 
        if @category.save
            redirect_to @category
	    else
	        render 'new'
	    end
    end

    def show
	    @category = Category.find(params[:id])
	end

	def index
	    @categories = Category.all
	end

	def edit
	    @category = Category.find(params[:id])
	end

	def update
	    @category = Category.find(params[:id])
	 
	    if @category.update_attributes(category_params)
	    	@category.save
	        redirect_to @category
	    else
	        render 'edit'
	    end
	end

	def destroy
	  	@category = Category.find(params[:id])
	  	@category.destroy
	 
	  	redirect_to categories_path
	end

    private
	    def category_params
	        params.require(:category).permit(:name)
	    end
end
