class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  authorize @offer

  def home
  end
end
