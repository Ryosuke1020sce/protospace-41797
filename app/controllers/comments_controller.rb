class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype # 一旦親プロトタイプの情報を取得する。
      @comments = @prototype.comments # その親プロトに属するコメントをすべて取得する。
      render "prototypes/show", status: :unprocessable_entity
    end
  end


  private
   
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id).merge(prototype_id: params[:prototype_id])
  end


end
