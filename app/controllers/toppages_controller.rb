class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(current_user.id)
    end
  end
  
  def howto
  end
end
