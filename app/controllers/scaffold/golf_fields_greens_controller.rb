class Scaffold::GolfFieldsGreensController < ApplicationController
  # GET /golf_fields_greens
  # GET /golf_fields_greens.json
  def index
    @golf_fields_greens = GolfFieldsGreen.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @golf_fields_greens }
    end
  end

  # GET /golf_fields_greens/1
  # GET /golf_fields_greens/1.json
  def show
    @golf_fields_green = GolfFieldsGreen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @golf_fields_green }
    end
  end

  # GET /golf_fields_greens/new
  # GET /golf_fields_greens/new.json
  def new
    @golf_fields_green = GolfFieldsGreen.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @golf_fields_green }
    end
  end

  # GET /golf_fields_greens/1/edit
  def edit
    @golf_fields_green = GolfFieldsGreen.find(params[:id])
  end

  # POST /golf_fields_greens
  # POST /golf_fields_greens.json
  def create
    @golf_fields_green = GolfFieldsGreen.new(params[:golf_fields_green])

    respond_to do |format|
      if @golf_fields_green.save
        format.html { redirect_to scaffold_golf_fields_green_url(@golf_fields_green), notice: 'Golf fields green was successfully created.' }
        format.json { render json: @golf_fields_green, status: :created, location: @golf_fields_green }
      else
        format.html { render action: "new" }
        format.json { render json: @golf_fields_green.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /golf_fields_greens/1
  # PUT /golf_fields_greens/1.json
  def update
    @golf_fields_green = GolfFieldsGreen.find(params[:id])

    respond_to do |format|
      if @golf_fields_green.update_attributes(params[:golf_fields_green])
        format.html { redirect_to scaffold_golf_fields_green_url(@golf_fields_green), notice: 'Golf fields green was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @golf_fields_green.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /golf_fields_greens/1
  # DELETE /golf_fields_greens/1.json
  def destroy
    @golf_fields_green = GolfFieldsGreen.find(params[:id])
    @golf_fields_green.destroy

    respond_to do |format|
      format.html { redirect_to scaffold_golf_fields_greens_url }
      format.json { head :ok }
    end
  end
end
