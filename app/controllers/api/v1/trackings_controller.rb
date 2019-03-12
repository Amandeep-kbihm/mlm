class Api::V1::TrackingsController < Api::BaseController

  before_action :make_transaction

  def icubeswire
    User.transaction do
      @transaction.data = '{company: "icubeswire"}'
      @conversion.company = 'icubeswire'
      give_reward
    end
  end

  def vcommission
    User.transaction do
      @transaction.data = '{company: "vcommission"}'
      @conversion.company = 'vcommission'
      give_reward
    end
  end

  def conversionx
    User.transaction do
      @transaction.data = '{company: "conversionx"}'
      @conversion.company = 'conversionx'
      give_reward
    end
  end

  private

  def make_transaction
    @transaction = Transaction.new
    @transaction.category = Transaction::CATEGORY[:pay_per_install]
    @transaction.user_id = params[:user_id]
    @transaction.wallet = @transaction.user.wallet
    @transaction.direction = Transaction::DIRECTION[:credit]
    @transaction.owner = true

    @conversion = Conversion.new
    @conversion.user_id = params[:user_id]
    @conversion.company_id = params[:offer_id]
    @conversion.transaction_id = params[:transaction_id]
    deal = Deal.find_by_id params[:id]
    if deal
      @transaction.amount = deal.amount
      if deal.company_id == @conversion.company_id.to_i && deal.active
        deal.downloaded += 1
        if deal.downloaded === deal.cap
          deal.active = false
        end
        deal.save!
        @conversion.deal = deal
      else
        render json: { status: true } and return
      end
    else
      render json: { status: true } and return
    end
  end

  def give_reward
    if @transaction.save!
      @conversion.save!
      wallet = @transaction.wallet
      wallet.balance += @transaction.amount
      wallet.save
    end
    render json: { status: true }
  end

end
