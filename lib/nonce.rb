module Nonce
  def new_nonce
    session[:nonce] = SecureRandom.hex(16)
  end

  def stored_nonce
    session.delete(:nonce)
  end
end