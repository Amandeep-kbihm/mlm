class Api::V1::WalletsController < Api::BaseController
  def balance
    render json: current_user.wallet
  end

end