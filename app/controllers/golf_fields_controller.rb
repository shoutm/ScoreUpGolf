class GolfFieldsController < ApplicationController
  # GET /golf_fields
  # GET /golf_fields.json
  def index
    @golf_fields = GolfField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @golf_fields }
    end
  end

  # GET /golf_fields/1
  # GET /golf_fields/1.json
  def show
    @golf_field = GolfField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @golf_field }
    end
  end

  # GET /golf_fields/new
  # GET /golf_fields/new.json
  def new
    @golf_field = GolfField.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @golf_field }
    end
  end

  # GET /golf_fields/1/edit
  def edit
    @golf_field = GolfField.find(params[:id])
  end

  # POST /golf_fields
  # POST /golf_fields.json
  def create
    @golf_field = GolfField.new(params[:golf_field])

    respond_to do |format|
      if @golf_field.save
        format.html { redirect_to @golf_field, notice: 'Golf field was successfully created.' }
        format.json { render json: @golf_field, status: :created, location: @golf_field }
      else
        format.html { render action: "new" }
        format.json { render json: @golf_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /golf_fields/1
  # PUT /golf_fields/1.json
  def update
    @golf_field = GolfField.find(params[:id])

    respond_to do |format|
      if @golf_field.update_attributes(params[:golf_field])
        format.html { redirect_to @golf_field, notice: 'Golf field was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @golf_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /golf_fields/1
  # DELETE /golf_fields/1.json
  def destroy
    @golf_field = GolfField.find(params[:id])
    @golf_field.destroy

    respond_to do |format|
      format.html { redirect_to golf_fields_url }
      format.json { head :ok }
    end
  end
end
