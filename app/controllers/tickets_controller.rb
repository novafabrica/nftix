class TicketsController < ApplicationController
  respond_to :json, :html, :js
  before_action :confirm_logged_in
  before_action :set_ticket, :only => [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.includes(:comments, :creator, :assignee).in_progress
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @comment = Comment.new
  end

  # GET /tickets/new
  def new
    params[:ticket] ||= {}
    ticket_params = {:ticket_group_id => session[:ticket_group]}.merge(params[:ticket])
    @ticket = Ticket.new(ticket_params)
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = @current_user.tickets.build(ticket_params)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, :notice => 'Ticket was successfully created.' }
        format.json { render :action => 'show', :status => :created, :location => @ticket }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, :notice =>  'Ticket was successfully Updated.' }
        format.js do
          render :json => @ticket.to_json
        end
      else
        format.html { render :action => 'edit' }
        format.js { render :json  => @ticket.errors, :status =>  :unprocessable_entity }
      end
    end

  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.update_attribute(:status, 'deleted')
    respond_to do |format|
      format.html do
        flash[:notice] = "Ticket was destroyed"
        redirect_to tickets_url
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:ticket_group_id, :owner_id, :creator_id, :name, :description, :status, :due_date, :comment_count)
    end
end
