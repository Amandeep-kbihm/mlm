class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :delete]

  def index
    respond_to do |format|
      format.html
      format.json { render(json: UserDatatable.new(view_context)) and return }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_update_params)
      redirect_to admin_show_user_path(@user)
    else
      redirect_to :back
    end
  end

  def delete
    if @user.destroy
      redirect_to admin_user_details_path, notice: 'User has deleted successfully'
    else
      redirect_to admin_user_details_path, alert: 'Error! '
    end
  end

  def activate_boost
    @user = User.find_by_id params[:id]
    @user.update(boost: true)
    respond_to do |format|
      format.html { redirect_to admin_user_details_path }
      format.js
    end
  end

  def change_status
    @user = User.find_by_id(params[:id])
    if @user.present?
      if @user.status == true
        @user.update(status: false)
        respond_to do |format|
          format.html { redirect_to admin_user_details_path, notice: 'User is deactivate' }
          format.js { @status = 0 }
        end
      elsif @user.status == false
        @user.update(status: true)
        message = "Welcome to EEARN, \nWe are pleased to inform that now you can earn unlimited by this app without any loss.\nLogin kare unlimited income ke liye"
        HTTParty.get("http://bhashsms.com/api/sendmsg.php?user=9646221722&pass=ba9854c&sender=TESTTO&phone=#{@user.mobile_number}&priority=ndnd&stype=normal&text=#{message}")
        respond_to do |format|
          format.html { redirect_to admin_user_details_path, notice: 'User is activate' }
          format.js { @status = 1 }
        end
      else
        respond_to do |format|
          format.html { redirect_to admin_user_details_path, alert: 'Error!' }
          format.js { @status = 2 }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_user_details_path, notice: 'User not found' }
        format.js { @status = 3 }
      end
    end
  end

  def user_tree
    @user = User.find_by_id(params[:id])
    @real_sponsor = User.find_by_sponsor_id(@user.real_sponsor_id)
    @direct_count = User.where(sponsor_id: @user.refer_id).count
    @levels_count = []
    (1..10).each do |level|
      @levels_count << @user.refers.where(level: level).count
    end
  end

  def user_tree_level
    @user = User.find_by_id params[:id]
    @level = params[:level]
    if @level == 'direct'
      @users = User.where(sponsor_id: @user.refer_id).pluck(:id).paginate(page: params[:page], per_page: 15)
    else
      @users = @user.refers.where(level: @level).pluck(:referred_id).paginate(page: params[:page], per_page: 15)
    end
  end

  def search
    @users = User.paginate(per_page: 10, page: params[:page]).search(user_search_params)
    @user = User.new user_search_params
    render 'index'
  end

  def notification
    @notification = Notification.new
  end

  def push_notification
    notification = Notification.new(notification_params)
    notification.save
    redirect_to admin_dashboard_path
  end

  def reset_device
    user = User.find_by_id params[:id]
    if user
      user.update(device_id: nil)
    end
    redirect_to :back, notice: 'Device ID reset done.'
  end

  def earnings

  end

  private

  def user_search_params
    params.require(:user).permit(:name, :mobile_number, :email, :refer_id, :sponsor_id, :status)
  end

  def set_user
    @user = User.find_by_id params[:id]
  end

  def user_update_params
    params.require(:user).permit(:name, :address, :city, :state, :country, :mobile_number, :email)
  end

end
