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

        @category.product_ids.each { |pid| 
        	@product = Product.find(pid)
    		n_c_ids = Array.new
    	    @product.category_ids.each { |cid| 
    		    if cid != @category.id.to_s
    			    n_c_ids << cid
    		    end 
    		} 
    		@product.category_ids = n_c_ids
    	    @product.save
    	}

	  	@category.destroy
	 
	  	redirect_to categories_path
	end

    private
	    def category_params
	        params.require(:category).permit(:name)
	    end
end
