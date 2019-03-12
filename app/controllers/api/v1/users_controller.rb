require 'resolv-replace'

class Api::V1::UsersController < Api::BaseController

  def create
    if params[:user] and params[:user][:access_token] and params[:user][:device_id]

      ak_user = HTTParty.get("https://graph.accountkit.com/v1.2/me/?access_token=#{params[:user][:access_token]}")
      begin
        ak_user = JSON.parse ak_user.body
      rescue
        render json: { errors: {
            access_token: ["can't be blank"]
        } } and return
      end

      device_user = User.find_by_device_id params[:user][:device_id]

      if ak_user['id']
        if User.find_by_mobile_number ak_user['phone']['number']
          resource = User.find_by_mobile_number ak_user['phone']['number']
          if device_user
            if && device_user.id === resource.id
            else
              render json: {
                errors: {
                  device: ['already registered']
                }
              } and return
            end
          end
          resource.authentication_token = nil
        else
          if device_user
            render json: {
              errors: {
                device: ['already registered']
              }
            } and return
          end
          resource = User.new
          resource.device_id = params[:user][:device_id]
          resource.mobile_number = ak_user['phone']['number']
          resource.status = User::STATUS[:unactivated]
          resource.password = Devise.friendly_token
          resource.refer_id = get_refer_id
        end

        if resource.save
          render json: UserSerializer.new(resource)
        else
          render json: { errors: resource.errors }
        end
      else
        render json: { errors: {
            access_token: ["can't be blank"]
        } }
      end
    else
      render json: { errors: {
          request: ["is not complete"]
      } }
    end
  end

  def complete_profile
    if params.has_key?(:user) && params[:user].has_key?(:sponsor_id) && params[:user].has_key?(:name) && params[:user][:name].length > 0 && params[:user][:sponsor_id].length >= 5
      if current_user.sponsor_id.nil?
        real_sponsor = User.where(refer_id: params[:user][:sponsor_id])
        if real_sponsor.count > 0
          real_sponsor = real_sponsor.last
          sponsor = find_sponsor real_sponsor.refer_id
          level = 1

          User.transaction do
            current_user.update(sponsor: sponsor, real_sponsor: real_sponsor, name: params[:user][:name])

            transaction = Transaction.create(category: Transaction::CATEGORY[:pay_per_refer],
                                             amount: Setting.refer_amount,
                                             transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
                                             status: Transaction::STATUS[:approved],
                                             owner: true,
                                             user_id: real_sponsor.id,
                                             wallet_id: real_sponsor.wallet.id,
                                             direction: Transaction::DIRECTION[:credit])
            transaction.save
            real_sponsor.wallet.add_money transaction.amount

            while sponsor
              ur = UserRefer.new(refer: sponsor, referred: current_user, level: level)
              ur.save

              sponsor = sponsor.sponsor
              level += 1
              if level > 10
                break
              end
            end

            render json: { status: true }
          end
        else
          render json: { status: false, message: 'Sponsor not found' }
        end
      else
        render json: { status: false, message: 'You already have a sponsor' }
      end
    else
      render json: { status: false, message: 'Fill the form correctly' }
    end
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      render json: { status: true, user: UserSerializer.new(@user) }
    else
      render json: { status: false }
    end
  end

  def sponsors
    @sponsors = User.order(created_at: :asc).limit(25).pluck(:refer_id)
  end

  def authenticate
    render json: { success: true, user: UserSerializer.new(current_user) }
  end

  private

  def complete_profile_params
    params.require(:user).permit(:name, :sponsor_id)
  end

  def profile_params
    params.require(:user).permit(:name, :dob, :address, :country, :state, :city, :fcm_token)
  end

  def get_refer_id
    refer_id = sprintf('%06d', rand(6**6))
    while User.where(refer_id: refer_id).count > 0
      refer_id = sprintf('%06d', rand(6**6))
    end
    refer_id
  end

  def check_and_return(users)
    users.each do |user|
      if user.referred.refers.where(level: 1).count < 5
        return user.referred
      end
    end
  end

  def find_sponsor(sponsor_id)
    top_user = User.find_by_refer_id sponsor_id
    if top_user.refers.where(level: 1).count < 5
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
    elsif top_user.refers.where(level: 10).count < 9765625
      return check_and_return top_user.refers.where(level: 9)
    else
      return check_and_return top_user.refers.where(level: 10)
    end
  end

end
