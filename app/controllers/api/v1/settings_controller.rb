class Api::V1::SettingsController < Api::BaseController

  def index
    @settings = Setting.all.select(:name, :value, :id)
    render json: { settings: @settings }
  end

end