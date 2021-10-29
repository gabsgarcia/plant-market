class OffersController < ApplicationController
  before_action :set_offer, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @offers = policy_scope(Offer).order(created_at: :desc)
  end

  def show

  end

  def new
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

  def update
    @offer.update(offer_params)
    redirect_to offer_path(@offer)
  end

  def edit
    @offer.update(offer_params)
    redirect_to offer_path(@offer)
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :category, :status, :description, :user_id, :buyer_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end
end
