# frozen_string_literal: true

class ToppagesController < ApplicationController
  def index
    redirect_to user_path(current_user.id) if user_signed_in?
  end

  def howto; end
end
