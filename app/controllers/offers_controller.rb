class OffersController < ApplicationController

  before_action :set_offer, only: [ :show, :edit, :update, :available, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]
  before_action :verify_authorized, only: [ :search ]
  DISTRICTS = [ "Butantã", "Cambuci", "Centro", "Consolação", "Liberdade", "Mooca", "Pinheiros", "Santana", "Saúde", "Sé", "Vila Leopoldina", "Vila Madalena", "Vila Mariana" ]

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

  def home
    authorize @offers
  end

  def show

  end

  def my_offers
    @offers = Offer.where(user: current_user)
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    authorize @offer
    @offer.user = current_user
    if @offer.save
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

  end



  def search
    if params[:district].present? && params[:category].present?
      @offers = Offer.where(district: params[:district], category: params[:category])
      @markers = @offers.geocoded.map do |offer|
        {
          lat: offer.latitude,
          lng: offer.longitude,
          info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
          image_url: helpers.asset_url('marker.png')
        }
      end
    else
      @offers = Offer.all
      @markers = @offers.geocoded.map do |offer|
        {
          lat: offer.latitude,
          lng: offer.longitude,
          info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
          image_url: helpers.asset_url('marker.png')
        }
      end
    end
  end

  private

  def verify_authorized
    true
  end

  def offer_params
    params.require(:offer).permit(:title, :category, :status, :description, :district, :photo, :address, :user_id, :buyer_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end
end
