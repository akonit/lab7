class LinksController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin"

	def new
		@p_id
		@c_id
    end

    def create()
    	@p_id = (params[:p_id])
    	@c_id = (params[:c_id])

        @product = Product.find(@p_id)
    	@category = Category.find(@c_id)

    	@product.category_ids << @c_id
    	@category.product_ids << @p_id
 
        if @product.save && @category.save
            redirect_to links_path
	    else
	        render 'new'
	    end
    end

    def index
	end

	def destroy
    	@p_id = (params[:p_id])
    	@c_id = (params[:c_id])

        @product = Product.find(@p_id)
    	@category = Category.find(@c_id)

        n_c_ids = Array.new
    	@product.category_ids.each { |cid| 
    		if cid != @c_id
    			n_c_ids << cid
    		end }
    	@product.category_ids = n_c_ids
    	@product.save

        n_p_ids = Array.new
    	@category.product_ids.each { |pid| 
    		if pid != @p_id
    			n_p_ids << pid
    		end }
    	@category.product_ids = n_p_ids
    	@category.save

	  	redirect_to links_path
	end

    private
	    def link_params
	        params.require(:link).permit(:product_id, :category_id)
	    end
end
