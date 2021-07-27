class ReviewsController < ApplicationController
      before_action :authenticate_user! 

      def create
            @idea = Idea.find params[:idea_id]  
            review_params = params.require(:review).permit(:body)
            @review = Review.new review_params
            @review.user = current_user 
            @review.idea = @idea
            @review.save
            if @review.persisted?
                  redirect_to idea_path(@idea), notice: 'review created!'
            else
                  redirect_to idea_path(@idea)
            end
      end

      def destroy
            @idea = Idea.find params[:idea_id]
            @review = Review.find params[:id]

            if can?(:crud, @review)
                  @review.destroy
                  redirect_to idea_path(@idea), notice: "Review Deleted"
            else
                  redirect_to root_path, alert: "Not authorized"
            end
      end
end
