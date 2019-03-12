class Admin::SettingsController < Admin::BaseController
  before_action :authenticate_user!

  def new

  end

  def index
    @settings = Setting.all.order(id: :desc)
  end

  def update
    params[:settings][:array].each do |setting|
      val = Setting.find setting[:key]
      val.update(value: setting[:value])
    end
    redirect_to :back, notice: 'Update Successfully'
  end


end
