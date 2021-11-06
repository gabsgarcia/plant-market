class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :maps, :update_position ]

  def home
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
