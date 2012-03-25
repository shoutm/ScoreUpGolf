class Scaffold::GolfCourcesController < ApplicationController
  # GET /golf_cources
  # GET /golf_cources.json
  def index
    @golf_cources = GolfCource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @golf_cources }
    end
  end

  # GET /golf_cources/1
  # GET /golf_cources/1.json
  def show
    @golf_cource = GolfCource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @golf_cource }
    end
  end

  # GET /golf_cources/new
  # GET /golf_cources/new.json
  def new
    @golf_cource = GolfCource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @golf_cource }
    end
  end

  # GET /golf_cources/1/edit
  def edit
    @golf_cource = GolfCource.find(params[:id])
  end

  # POST /golf_cources
  # POST /golf_cources.json
  def create
    @golf_cource = GolfCource.new(params[:golf_cource])

    respond_to do |format|
      if @golf_cource.save
        format.html { redirect_to scaffold_golf_cource_url(@golf_cource), notice: 'Golf cource was successfully created.' }
        format.json { render json: @golf_cource, status: :created, location: @golf_cource }
      else
        format.html { render action: "new" }
        format.json { render json: @golf_cource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /golf_cources/1
  # PUT /golf_cources/1.json
  def update
    @golf_cource = GolfCource.find(params[:id])

    respond_to do |format|
      if @golf_cource.update_attributes(params[:golf_cource])
        format.html { redirect_to scaffold_golf_cource_url(@golf_cource), notice: 'Golf cource was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @golf_cource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /golf_cources/1
  # DELETE /golf_cources/1.json
  def destroy
    @golf_cource = GolfCource.find(params[:id])
    @golf_cource.destroy

    respond_to do |format|
      format.html { redirect_to scaffold_golf_cources_url }
      format.json { head :ok }
    end
  end
end
