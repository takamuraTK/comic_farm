class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @subs = @user.books
  end
  
    
end
