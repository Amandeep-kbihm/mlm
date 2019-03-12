class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user

  layout 'admin'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :notice => exception.message
  end

  private

  def check_user
    return unless user_signed_in?
    unless current_user.has_role?(:admin)
      redirect_to new_user_session_path, :notice => 'Not Authorized !'
    end
  end

end
