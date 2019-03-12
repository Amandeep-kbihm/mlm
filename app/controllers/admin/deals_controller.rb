class Admin::DealsController < Admin::BaseController

  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  def index
    @deals = Deal.paginate(per_page: 20, page: params[:page])
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new deal_params
    if @deal.save
      flash[:success] = 'Deal created successfully'
      redirect_to admin_deals_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @deal.update deal_params
      redirect_to admin_deal_path(@deal)
    else
      render 'edit'
    end
  end

  def destroy
    if @deal.destroy
      redirect_to admin_deals_path
    else
      redirect_back fallback_location: admin_deal_path(@deal)
    end
  end

  private

  def set_deal
    @deal = Deal.find_by_id params[:id]
  end

  def deal_params
    params.require(:deal).permit(:company_id, :downloaded, :link, :logo, :name, :instructions, :active, :amount, :cap)
  end

end
