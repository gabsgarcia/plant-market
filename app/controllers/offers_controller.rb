class OffersController < ApplicationController
  before_action :set_offer, only: [ :show, :edit, :update, :destroy, :available ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  DISTRICTS = ["Vila Mariana", "Liberdade", "Vila Madalena"]

  def index
    @offers = policy_scope(Offer).order(created_at: :desc)
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
        image_url: helpers.asset_url('marker.png')
      }
    end
  end

  def show

  end

  def new
    @districts = DISTRICTS
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      authorize @offer
      redirect_to offer_path(@offer)
    else
      render "new"
    end
  end

  def destroy
    if @offer.destroy
      redirect_to offers_path
    else
      render "destroy"
    end
  end

  def available
    @offer.update(status: !@offer.status)
    redirect_to offer_path(@offer)
  end

  def update
    @offer.update(offer_params)
    redirect_to offer_path(@offer)
  end

  def edit
    @districts = DISTRICTS
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :category, :status, :description,
                                  :address, :district, :user_id, :buyer_id, :photo)
  end

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end
end
