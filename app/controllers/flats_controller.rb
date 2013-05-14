class FlatsController < ApplicationController
  # GET /flats
  # GET /flats.json
  def index
    if params[:name] != nil && params[:name] != ""
    	@flats = Flat.where("name like ?", "%#{params[:name]}%")
    	@notice = "listing flats with name like #{params[:name]}"
    elsif params[:search].present?
    	@flats_zone = Flat.near(params[:search], 12, :order => :distance)
    	@notice = "listing flats in: #{params[:search]}"
    	if params[:rooms] == nil || params[:rooms] == ""
    		@flats = @flats_zone
    	else
    		@flats = []
    		@flats_zone.each do |flat|
    			if flat.bedroom_count == params[:rooms].to_i
    				@flats << flat
    				@notice = "listing flats with #{params[:rooms]} rooms in: #{params[:search]}"
    			end
    		end
    	end
    elsif params[:rooms] != nil && params[:rooms] != ""
    	@flats = Flat.where(:bedroom_count == params[:rooms].to_i)  	
    else
    	@flats = Flat.all
    end
  end

  # GET /flats/1
  # GET /flats/1.json
  def show
    @flat = Flat.find(params[:id])
  end

  # GET /flats/new
  # GET /flats/new.json
  def new
    @flat = Flat.new
  end

  # GET /flats/1/edit
  def edit
    @flat = Flat.find(params[:id])
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = Flat.new(params[:flat])

    respond_to do |format|
      if @flat.save
        format.html { redirect_to @flat, notice: 'Flat was successfully created.' }
        format.json { render json: @flat, status: :created, location: @flat }
      else
        format.html { render action: "new" }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flats/1
  # PUT /flats/1.json
  def update
    @flat = Flat.find(params[:id])

    respond_to do |format|
      if @flat.update_attributes(params[:flat])
        format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1
  # DELETE /flats/1.json
  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy

    respond_to do |format|
      format.html { redirect_to flats_url }
      format.json { head :no_content }
    end
  end
end
