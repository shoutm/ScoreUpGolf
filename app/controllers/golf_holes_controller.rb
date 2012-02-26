class GolfHolesController < ApplicationController
  # GET /golf_holes
  # GET /golf_holes.json
  def index
    @golf_holes = GolfHole.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @golf_holes }
    end
  end

  # GET /golf_holes/1
  # GET /golf_holes/1.json
  def show
    @golf_hole = GolfHole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @golf_hole }
    end
  end

  # GET /golf_holes/new
  # GET /golf_holes/new.json
  def new
    @golf_hole = GolfHole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @golf_hole }
    end
  end

  # GET /golf_holes/1/edit
  def edit
    @golf_hole = GolfHole.find(params[:id])
  end

  # POST /golf_holes
  # POST /golf_holes.json
  def create
    @golf_hole = GolfHole.new(params[:golf_hole])

    respond_to do |format|
      if @golf_hole.save
        format.html { redirect_to @golf_hole, notice: 'Golf hole was successfully created.' }
        format.json { render json: @golf_hole, status: :created, location: @golf_hole }
      else
        format.html { render action: "new" }
        format.json { render json: @golf_hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /golf_holes/1
  # PUT /golf_holes/1.json
  def update
    @golf_hole = GolfHole.find(params[:id])

    respond_to do |format|
      if @golf_hole.update_attributes(params[:golf_hole])
        format.html { redirect_to @golf_hole, notice: 'Golf hole was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @golf_hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /golf_holes/1
  # DELETE /golf_holes/1.json
  def destroy
    @golf_hole = GolfHole.find(params[:id])
    @golf_hole.destroy

    respond_to do |format|
      format.html { redirect_to golf_holes_url }
      format.json { head :ok }
    end
  end
end
