class CommentsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_comment, only: [:edit, :update, :destroy]
  respond_to :json

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.build(comment_params)
    @comment.user = @current_user
    if @comment.save
      render :json => {
        :success => true,
        :html => render_to_string(:partial => "comment", :locals => {:comment => @comment })
      }
    else
      render :status => 424, :json => {
        :success => false
      }
    end
  end

  def edit
    return render :status => 403, :json => {:success => false} unless @comment
    render :json => {
        :success => true,
        :html => render_to_string(:partial => "form")
      }
  end

  def update
    return render :status => 403, :json => {:success => false} unless @comment
    if @comment.update(comment_params)
      render :json => {
        :success => true,
        :html => render_to_string(:partial => "comment", :locals => {:comment => @comment })
      }
    else
      render :status => 424, :json => {
        :success => false
      }
    end
  end

  def destroy
    return render :status => 403, :json => {:success => false} unless @comment
    if @comment.delete
      render :status => 204, :json => {
        :success => true
      }
    else
      render :status => 424, :json => {
        :success => false
      }
    end
  end


  private

  def find_comment
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.where(:id => params[:id], :user_id => @current_user.id).first
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
