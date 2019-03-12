class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  layout  :layout_for



  # def check_user
  #   if user_signed_in?
  #     if !current_user.status
  #       sign_out current_user
  #       render json: {msg: 'Sorry!'}
  #     end
  #   end
  # end

  private
  def layout_for
    if controller_name == 'sessions'
      'login'
    else
      'application'
    end
  end

end
