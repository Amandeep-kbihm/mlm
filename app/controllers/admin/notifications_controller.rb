require 'fcm'
class Admin::NotificationsController < Admin::BaseController

  def new
    @notification = Notification.new
  end

  def create
    notification = Notification.new(notification_params)
    if notification.save
      fcm = FCM.new('AAAATmqsE5Q:APA91bG596H3WABKQ09zlotop_3L4RqfFBrPOYs92gqLK1bJ94mqFJdyzVHMINPj8dO4JSr1FOmB9yXe8HrbMs-l0TLV7FpofEnbLNmOJtgVLEuKFI2FGOb18IqdL9F9RQnKKkpgqSbm')
      User.where('fcm_token != ""').in_batches do |users|
        registration_ids = users.pluck(:fcm_token)
        options = {notification: { body: notification.body, sound: 'default' }}
        fcm.send(registration_ids, options)
      end
    end
    redirect_to admin_admin_dashboard_path
  end

  private

  def notification_params
    params.require(:notification).permit(:body)
  end

end