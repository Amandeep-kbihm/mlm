require 'httparty'
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_version

  respond_to :json

# GET /resource/sign_up
  def new

  end

# POST /resource
  def create
    build_resource(sign_up_params)
    resource.email = nil
    if resource.sponsor_id.present?
      sponsor = find_sponsor(resource.sponsor_id)
      real_sponsor = User.find_by_refer_id(resource.sponsor_id)
    else
      sponsor = find_sponsor(User.first.refer_id)
      real_sponsor = User.first
    end

    if real_sponsor
      resource.refer_id = SecureRandom.hex(3).upcase
      resource.sponsor_id = sponsor.refer_id
      resource.real_sponsor_id = real_sponsor.refer_id
      resource.status = false
      resource.otp = (SecureRandom.random_number * 1000000).to_i
      resource.refer_income = 1
      resource.save

      yield resource if block_given?
      if resource.persisted?
        HTTParty.get("https://control.msg91.com/api/sendotp.php?authkey=170780AiTW72TYM97l59996cf9&mobile=#{resource.mobile_number}&message=Your+OTP+is+#{resource.otp}&sender=FIERTE&otp=#{resource.otp}")
        if User.where(real_sponsor_id: real_sponsor.refer_id).count >= 5
          real_sponsor.update(boost: true)
        end
        level = 1
        while sponsor do
          sponsor.update(chain_count: sponsor.chain_count + 1)
          UserRefer.create(refer_id: sponsor.id, referred_id: resource.id, level: level)
          sponsor = sponsor.sponsor
          level += 1
        end
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end

    else
      render json: { errors: { refer_id: ['Sponsor ID not valid!'] }}
    end

  end

# GET /resource/edit
# def edit
#   super
# end

# PUT /resource
#  def update
#    super
#  end

# DELETE /resource
# def destroy
#   super
# end

# GET /resource/cancel
# Forces the session data which is usually expired after sign
# in to be expired now. This is useful if the user wants to
# cancel oauth signing in/up in the middle of the process,
# removing all OAuth session data.
# def cancel
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile_number, :email, :country, :state,
                                                       :city, :address, :sponsor_id, :dob])
  end

# If you have extra params to permit, append them to the sanitizer.
# def configure_account_update_params
#   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
# end

# The path used after sign up.
# def after_sign_up_path_for(resource)
#   super(resource)
# end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end

  private

  def check_and_return(users)
    users.each do |user|
      if user.referred.level_1_users.count < 5
        return user.referred
      end
    end
  end

  def find_sponsor(sponsor_id)
    top_user = User.find_by_refer_id sponsor_id
    return if top_user.nil?
    # Direct check. If less than 5 then it is a direct joining
    if top_user.level_1_users.count < 5
      top_user
    elsif top_user.refers.where(level: 2).count < 25
      return check_and_return top_user.refers.where(level: 1)
    elsif top_user.refers.where(level: 3).count < 125
      return check_and_return top_user.refers.where(level: 2)
    elsif top_user.refers.where(level: 4).count < 625
      return check_and_return top_user.refers.where(level: 3)
    elsif top_user.refers.where(level: 5).count < 3125
      return check_and_return top_user.refers.where(level: 4)
    elsif top_user.refers.where(level: 6).count < 15625
      return check_and_return top_user.refers.where(level: 5)
    elsif top_user.refers.where(level: 7).count < 78125
      return check_and_return top_user.refers.where(level: 6)
    elsif top_user.refers.where(level: 8).count < 390625
      return check_and_return top_user.refers.where(level: 7)
    elsif top_user.refers.where(level: 9).count < 1953125
      return check_and_return top_user.refers.where(level: 8)
    else
      return check_and_return top_user.refers.where(level: 9)
    end
  end

  def check_version
    if request.headers['X-App-Version'].to_f < Setting.min_app_version.to_f
      render json: { update_app: true }
    end
  end

end
