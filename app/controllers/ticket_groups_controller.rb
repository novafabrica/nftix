class TicketGroupsController < ApplicationController
  before_action :set_ticket_group, only: [:show, :edit, :update, :destroy]

  # GET /ticket_groups
  # GET /ticket_groups.json
  def index
    @ticket_groups = TicketGroup.all
  end

  # GET /ticket_groups/1
  # GET /ticket_groups/1.json
  def show
    @tickets = @ticket_group.tickets
  end

  # GET /ticket_groups/new
  def new
    @ticket_group = TicketGroup.new
  end

  # GET /ticket_groups/1/edit
  def edit
  end

  # POST /ticket_groups
  # POST /ticket_groups.json
  def create
    @ticket_group = TicketGroup.new(ticket_group_params)

    respond_to do |format|
      if @ticket_group.save
        format.html { redirect_to @ticket_group, notice: 'Ticket group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_groups/1
  # PATCH/PUT /ticket_groups/1.json
  def update
    respond_to do |format|
      if @ticket_group.update(ticket_group_params)
        format.html { redirect_to @ticket_group, notice: 'Ticket group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_groups/1
  # DELETE /ticket_groups/1.json
  def destroy
    @ticket_group.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "Group Destroyed"
        redirect_to ticket_groups_url
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_group
      @ticket_group = TicketGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_group_params
      params.require(:ticket_group).permit(:name, :position, :active, :ticket_count)
    end
end
