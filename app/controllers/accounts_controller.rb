class AccountsController < ApplicationController
  before_filter :require_authentication

  def show
    @open_id = current_account.open_id
    @user_info = @open_id.to_access_token.user_info!
  end

  def destroy
    current_account.destroy
    unauthenticate!
    redirect_to root_url
  end
end
