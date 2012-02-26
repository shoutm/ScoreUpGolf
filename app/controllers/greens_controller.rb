class GreensController < ApplicationController
  # GET /greens
  # GET /greens.json
  def index
    @greens = Green.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @greens }
    end
  end

  # GET /greens/1
  # GET /greens/1.json
  def show
    @green = Green.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @green }
    end
  end

  # GET /greens/new
  # GET /greens/new.json
  def new
    @green = Green.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @green }
    end
  end

  # GET /greens/1/edit
  def edit
    @green = Green.find(params[:id])
  end

  # POST /greens
  # POST /greens.json
  def create
    @green = Green.new(params[:green])

    respond_to do |format|
      if @green.save
        format.html { redirect_to @green, notice: 'Green was successfully created.' }
        format.json { render json: @green, status: :created, location: @green }
      else
        format.html { render action: "new" }
        format.json { render json: @green.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /greens/1
  # PUT /greens/1.json
  def update
    @green = Green.find(params[:id])

    respond_to do |format|
      if @green.update_attributes(params[:green])
        format.html { redirect_to @green, notice: 'Green was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @green.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greens/1
  # DELETE /greens/1.json
  def destroy
    @green = Green.find(params[:id])
    @green.destroy

    respond_to do |format|
      format.html { redirect_to greens_url }
      format.json { head :ok }
    end
  end
end
