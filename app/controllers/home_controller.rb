class HomeController < ApplicationController

  def index
    @pending_cb = ApartmentCallback.outstanding
  end

end
