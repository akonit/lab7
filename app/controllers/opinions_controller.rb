class OpinionsController < ApplicationController

	def create
	    @product = Product.find(params[:product_id])
	    @opinion = Opinion.new(opinion_params)
	    @opinion.save
	    @product.opinions << @opinion
	    @product.save
	    redirect_to product_path(@product)
	end
	 
	private
	    def opinion_params
	        params.require(:opinion).permit(:text, :login)
	end
end
