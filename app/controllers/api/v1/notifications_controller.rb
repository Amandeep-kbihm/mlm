class Api::V1::NotificationsController < Api::BaseController

  def index
    @notifications = Notification.order(id: :desc).paginate(per_page: 10, page: params[:page])
    render json: @notifications
  end

end