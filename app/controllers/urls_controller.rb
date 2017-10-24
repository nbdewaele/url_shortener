class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
		@url = Url.new
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
		@url = Url.find_byshort_url([params[:id]])
		redirect_to @url.long_url
  end

  # POST /urls
  # POST /urls.json
  def create
    url = Url.new(url_params)

		if url.save!
			# i should generate a short url
			url.update!(short_url: SecureRandom.base64(5).split("=").first)
			url.save!
			redirect_to root_path
		else
			render :index
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      return params.require(:url).permit(:long_url)
    end
end
