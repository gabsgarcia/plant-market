class OffersController < ApplicationController

  def index
    @offers = policy_scope(Offer).order(created_at: :desc)
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render "new"
    end
  end

  def show
    @offer = Offer.find(params[:id])
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
end
