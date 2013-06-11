class PagesController < ApplicationController
  before_filter :user_authenticated
  skip_before_filter :user_authenticated, :only => :login

  def dashboard
  end

  private
  def user_authenticated
    redirect_to "/login" unless current_user
  end
end
