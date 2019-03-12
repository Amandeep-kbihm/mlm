class Api::V1::UserActionsController < Api::BaseController

  def create
    @click_ad = UserAction.new(user_action_params)
    if @click_ad.save
      render json: {status: :success}
    else
      render json: {status: :failed, errors: @click_ad.errors}
    end
  end


  private
  def user_action_params
    params.require(:user_action).permit(:category, :user_id, :paid)
  end
end
