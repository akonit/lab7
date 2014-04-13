class ProductsController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

	def new
		@product = Product.new
    end

    def create
    	@product = Product.new(product_params)
 
        if @product.save
            redirect_to @product
	    else
	        render 'new'
	    end
    end

    def show
	    @product = Product.find(params[:id])
	    @categories = Array.new
	    @product.category_ids.each { |cid|
        	@category = Category.find(cid)
        	@categories << @category.name
        }
	    @rating = @product.ratings.where(:score => 0).first
	    if @rating == nil
		    @rating = Rating.new(score: 0)
		    @rating.hash = @rating.id.hash().to_s()
		    @product.ratings << @rating
	        @product.save!
	    end
	end

	def index
	    if params[:search]
      	    @products = Product.where(description: /#{params[:search]}/).all
    	else
      		@products = Product.all
    	end
	end

	def edit
	    @product = Product.find(params[:id])
	end

	def update
	    @product = Product.find(params[:id])
	 
	    if @product.update_attributes(product_params)
	        redirect_to @product
	    else
	        render 'edit'
	    end
	end

	def destroy
	  	@product = Product.find(params[:id])

        @product.category_ids.each { |cid|
        	@category = Category.find(cid)
    		n_p_ids = Array.new
    	    @category.product_ids.each { |pid| 
    		    if pid != @product.id.to_s
    			    n_p_ids << pid
    		    end 
    		} 
    		@category.product_ids = n_p_ids
    	    @category.save
    	}

	  	@product.destroy
	 
	  	redirect_to products_path
	end

    private
	    def product_params
	        params.require(:product).permit(:name, :description)
	    end
end
