class AccountsController < ApplicationController
  before_filter :require_authentication

  def show
    @open_id = current_account.open_id
    @user_info = @open_id.to_access_token.user_info!
    @providers = current_account.providers
  end
end
