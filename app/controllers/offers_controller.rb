class OffersController < ApplicationController
  before_action :set_offer, only: [ :show, :edit, :update, :destroy ]

  def index
    @offers = policy_scope(Offer).order(created_at: :desc)
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      authorize @offer
      redirect_to offer_path(@offer)
    else
      render "new"
    end
  end

  def show

  end

  def destroy

  end

  def update

  end

  def edit

  end

  private

  def offer_params
    params.require(:offer).permit(:title, :category, :status)
  end

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end

end
