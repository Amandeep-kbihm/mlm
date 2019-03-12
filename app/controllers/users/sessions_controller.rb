class Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :check_version

# before_action :configure_sign_in_params, only: [:create]

# GET /resource/sign_in
#   def new
#
#   end

# POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    if resource
      device_id = params[:user][:device_id]
      if current_user.block?
        sign_out resource
        render json: { error: 'Your account is inactive. Contact admin.' } and return
      elsif device_id.nil? || Setting.limit_devices.nil?
        resource.authentication_token = nil
        resource.save
        respond_to do |format|
          format.html { redirect_to admin_admin_dashboard_path }
          format.json { render json: resource }
        end
      elsif current_user.device_id.nil?
        user = User.where(device_id: device_id)
        if user.count === 0
          resource.device_id = device_id
          resource.authentication_token = nil
          resource.save
          respond_to do |format|
            format.html { redirect_to admin_admin_dashboard_path }
            format.json { render json: resource }
          end
        elsif user.first.id === resource.id
          resource.device_id = device_id
          resource.authentication_token = nil
          resource.save
          respond_to do |format|
            format.html { redirect_to admin_admin_dashboard_path }
            format.json { render json: resource }
          end
        else
          sign_out resource
          render json: { error: 'Unauthorized device' } and return
        end
      elsif current_user.device_id == device_id
        resource.authentication_token = nil
        resource.save
        respond_to do |format|
          format.html { redirect_to admin_admin_dashboard_path }
          format.json { render json: resource }
        end
      else
        sign_out resource
        render json: { error: 'Unauthorized device' } and return
      end
    end
  end

  private

  def check_version
    if request.format.json? and request.headers['X-App-Version'].to_f < Setting.min_app_version.to_f
      render json: { update_app: true }
    end
  end

  # DELETE /resource/sign_out
  #  def destroy
  #
  #  end

  #protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
