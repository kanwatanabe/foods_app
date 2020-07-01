class CommentsController < ApplicationController

before_action :set_micropost, only: %i[create destroy]

def create
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost_id]
    @comment.user_id = current_user.id
      if @comment.save
        # render :index
        flash[:success] = 'コメントしました'
        # redirect_to @comment.micropost
        
      else
        @micropost = Micropost.find(params[:micropost_id])  
        @comments = @micropost.comments
        render template: 'microposts/show'
      end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        # render :index
        flash[:success] = 'コメントを削除しました'
        # redirect_to @comment.micropost
        
    end

    private

    def set_micropost
        @micropost = Micropost.find(params[:micropost_id])
    end

    def comment_params
        params.require(:comment).permit(:content, :micropost_id, :user_id)
    end
end
