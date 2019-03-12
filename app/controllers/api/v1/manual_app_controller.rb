class Api::V1::ManualAppController < Api::BaseController
  def index
    @manual_apps = ManualApp.where(active: true)
  end
end
