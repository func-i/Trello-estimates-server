class PagesController < ApplicationController
  skip_before_filter :user_authenticated, :only => :login
  skip_before_filter :load_all_users, :only => :login

  def dashboard
    board_unfiltered = current_user.find(:members, "me").boards
    @boards = board_unfiltered.reject{ |b| b.closed? }
  end

  def login
    set_client_token
  end

  private

    def set_client_token
      @rt = OAuth::RequestToken.new(@consumer, @request_token.token, @request_token.secret)
      @at = @rt.get_access_token(:oauth_verifier => params["oauth_verifier"])

      set_current_user(@at)
      redirect_to root_path
    end

end
