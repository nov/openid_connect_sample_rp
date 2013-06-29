class AccountsController < ApplicationController
  before_filter :require_authentication

  def show
    @open_id = current_account.open_id
    @userinfo = @open_id.to_access_token.userinfo!
    @providers = current_account.providers
  end
end
