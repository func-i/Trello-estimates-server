class HarvestTrellosController < ApplicationController
  # GET /harvest_trellos
  # GET /harvest_trellos.json
  def index
    @harvest_trellos = HarvestTrello.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @harvest_trellos }
    end
  end

  # GET /harvest_trellos/1
  # GET /harvest_trellos/1.json
  def show
    @harvest_trello = HarvestTrello.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @harvest_trello }
    end
  end

  # GET /harvest_trellos/new
  # GET /harvest_trellos/new.json
  def new
    @harvest_trello = HarvestTrello.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @harvest_trello }
    end
  end

  # GET /harvest_trellos/1/edit
  def edit
    @harvest_trello = HarvestTrello.find(params[:id])
  end

  # POST /harvest_trellos
  # POST /harvest_trellos.json
  def create
    @harvest_trello = HarvestTrello.new(harvest_trello_params)

    respond_to do |format|
      if @harvest_trello.save
        format.html { redirect_to @harvest_trello, notice: 'Harvest trello was successfully created.' }
        format.json { render json: @harvest_trello, status: :created, location: @harvest_trello }
      else
        format.html { render action: "new" }
        format.json { render json: @harvest_trello.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /harvest_trellos/1
  # PUT /harvest_trellos/1.json
  def update
    @harvest_trello = HarvestTrello.find(params[:id])

    respond_to do |format|
      if @harvest_trello.update_attributes(harvest_trello_params)
        format.html { redirect_to @harvest_trello, notice: 'Harvest trello was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @harvest_trello.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /harvest_trellos/1
  # DELETE /harvest_trellos/1.json
  def destroy
    @harvest_trello = HarvestTrello.find(params[:id])
    @harvest_trello.destroy

    respond_to do |format|
      format.html { redirect_to harvest_trellos_url }
      format.json { head :no_content }
    end
  end

  private

  def harvest_trello_params
    params.require(:harvest_trello).permit(
      :harvest_project_id,
      :harvest_project_name,
      :trello_board_name,
      :trello_board_id
    )
  end
end
