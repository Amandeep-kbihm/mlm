class Admin::PasswordsController < Admin::BaseController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 15).order(id: :desc)
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.present?
      if params[:user][:password] == params[:user][:password_confirmation]
        @user.update(password_params)
        redirect_to admin_password_index_path, notice: 'Password Update Successfully'
      else
        redirect_to  admin_password_index_path, alert: 'New Password and Confirm Password does not match'
      end
    else
      redirect_to admin_password_index_path, alert: 'User does not exist'
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
