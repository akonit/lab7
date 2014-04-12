class RatingsController < ApplicationController

    def rate
        hash = params[:p1] + params[:p2]
        @rating = Rating.where(hash: hash).first
	    @product = @rating.product
	    if @rating.update_attributes(score: params[:score])
	      redirect_to @product
	    end
  end
end
