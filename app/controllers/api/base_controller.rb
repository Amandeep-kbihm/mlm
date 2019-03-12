class Api::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_version

  respond_to :json

  acts_as_token_authentication_handler_for User, fallback: :exception, if: lambda { |controller|
    (
    (controller.class.name == 'Users::RegistrationsController' && controller.action_name == 'create') ||
        (controller.class.to_s == 'Users::PasswordsController' &&
            (controller.action_name == 'create' || controller.action_name == 'edit' || controller.action_name == 'updatejson' ) ||
            (controller.class.name == 'Api::V1::UsersController' && (controller.action_name == 'sponsors' || controller.action_name === 'create')) ||
            (controller.class.name === 'Api::V1::TrackingsController')
        )
    ) ? false : true
  }

  protected

  def check_version
    if request.format.json? and request.headers['X-App-Version'].to_f < Setting.min_app_version.to_f
      render json: { update_app: true }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :sponsor_id, :address, :country,
                                                       :state, :city, :mobile_number, :dob])
  end

  def class_name
    puts self.class.name == 'Users::RegistrationsController' && self.action_name == 'create'
  end

end
