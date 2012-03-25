class Scaffold::ShotResultsController < ApplicationController
  # GET /shot_results
  # GET /shot_results.json
  def index
    @shot_results = ShotResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shot_results }
    end
  end

  # GET /shot_results/1
  # GET /shot_results/1.json
  def show
    @shot_result = ShotResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shot_result }
    end
  end

  # GET /shot_results/new
  # GET /shot_results/new.json
  def new
    @shot_result = ShotResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shot_result }
    end
  end

  # GET /shot_results/1/edit
  def edit
    @shot_result = ShotResult.find(params[:id])
  end

  # POST /shot_results
  # POST /shot_results.json
  def create
    @shot_result = ShotResult.new(params[:shot_result])

    respond_to do |format|
      if @shot_result.save
        format.html { redirect_to scaffold_shot_result_path(@shot_result), notice: 'Shot result was successfully created.' }
        format.json { render json: @shot_result, status: :created, location: @shot_result }
      else
        format.html { render action: "new" }
        format.json { render json: @shot_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shot_results/1
  # PUT /shot_results/1.json
  def update
    @shot_result = ShotResult.find(params[:id])

    respond_to do |format|
      if @shot_result.update_attributes(params[:shot_result])
        format.html { redirect_to scaffold_shot_result_path(@shot_result), notice: 'Shot result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shot_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shot_results/1
  # DELETE /shot_results/1.json
  def destroy
    @shot_result = ShotResult.find(params[:id])
    @shot_result.destroy

    respond_to do |format|
      format.html { redirect_to scaffold_shot_results_url }
      format.json { head :ok }
    end
  end
end
