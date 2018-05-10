class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.where(nil).order("created_at DESC")
    if !params[:search].blank? && !params[:search][:location].blank?
      url = "https://maps.googleapis.com/maps/api/place/textsearch/json?input=#{params[:search][:location]}&key=AIzaSyB3FXtpUa5MQ_rX_frJUEWx9hGJSwb0qJ4"
      response = open(url).read
      response_json = JSON.parse(response)
      location = response_json["results"][0]["geometry"]["location"]
      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location["lat"]},#{location["lng"]}&radius=1500&key=AIzaSyB3FXtpUa5MQ_rX_frJUEWx9hGJSwb0qJ4"
      response = open(url).read
      response_json = JSON.parse(response)

      locations = [params[:search][:location]]
      response_json["results"].each do |result|
        locations << result["name"]
      end
      @pictures = @pictures.location_search(locations).order("created_at DESC")
    elsif params[:location]
      @pictures = @pictures.location_search([params[:location]]).order("created_at DESC")
    end
    @pictures
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    if @current_user
      @picture = Picture.new
    else
      redirect_to root_path, notice: "Must be signed in to upload a picture!"
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:path, :description, :user_id, :likes, :location)
    end
end
