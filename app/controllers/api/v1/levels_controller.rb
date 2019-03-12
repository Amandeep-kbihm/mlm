class Api::V1::LevelsController < Api::BaseController
  def show
    @level = params[:level]
    @refers = current_user.refers.where(level: @level).paginate(page: params[:page], per_page: 5)
  end

  def general
    result = []
    (1..10).each do |level|
      result << {
          level: level,
          users: current_user.refers.where(level: level).count
      }
    end
    render json: { levels: result }
  end

  def get_first_level
    user = params[:user_id]
    @refers = User.find_by_id(user).refers.where(level: 1).paginate(page: params[:page], per_page: 5)
    render 'show'
  end

  def upline
    sponsors = []
    sponsor = current_user.sponsor
    until sponsor.nil?
      sponsors << UserSerializer.new(sponsor)

      sponsor = sponsor.sponsor
    end

    render json: { sponsors: sponsors }
  end

end
