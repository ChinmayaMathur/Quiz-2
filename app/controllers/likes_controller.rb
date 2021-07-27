class LikesController < ApplicationController
      def create
            @idea = Idea.find params[:idea_id]
            @like = Like.new(idea: @idea, user: current_user)
            if cannot?(:like, @idea)
                  flash[:alert] = "You can't like your own idea!"
            elsif @like.save
                  flash[:notice] = "Idea liked"
            else
                  flash[:alert] = @like.errors.full_messages.join(',')
            end
            redirect_to request.referrer
      end

      def destroy
            @like = current_user.likes.find params[:id]
            #!can? and cannot? is the same thing
            if cannot?(:destroy, @like)
                  flash[:alert] = "You cannot destroy a like you don't own"
            elsif @like.destroy
                  flash[:notice] = "Idea unliked"
            else
                  flash[:alert] = "Couldn't unlike the idea"
            end
            redirect_to request.referrer
      end
end
