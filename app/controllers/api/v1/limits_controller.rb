class Api::V1::LimitsController < Api::BaseController
  before_action :get_limit

  def index
    render json: { limit: @limit }
  end

  def ppc
    if current_user.boost? and @limit.ppc < Setting.ppc_boost_limit.to_i
      work = true
    elsif @limit.ppc < Setting.ppc_limit.to_i
      work = true
    else
      work = false
    end
    if work
      @limit.update(ppc: @limit.ppc + 1)
      amount = Setting.ppc_amount.to_f * 0.7
      limit_transaction = Transaction.create(category: Transaction::CATEGORY[:pay_per_click],
                                             amount: amount,
                                             transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
                                             direction: Transaction::DIRECTION[:credit],
                                             wallet_id: @limit.user.wallet.id,
                                             status: Transaction::STATUS[:pending],
                                             user_id: @limit.user.id,
                                             owner: true
      )
      if limit_transaction
        check_upline_reward(@limit)
        give_upline_reward current_user, Setting.ppc_amount.to_f, Transaction::CATEGORY[:pay_per_click]
      end
      # @limit.user.wallet.update(balance: @limit.user.wallet.balance + limit_transaction.amount)
      render json: { status: true, ppc: @limit.ppc }
    else
      render json: { status: false }
    end
  end

  def ppv
    if current_user.boost? and @limit.ppv < Setting.ppv_boost_limit.to_i
      work = true
    elsif @limit.ppv < Setting.ppv_limit.to_i
      work = true
    else
      work = false
    end
    if work
      @limit.update(ppv: @limit.ppv + 1)
      amount = Setting.ppv_amount.to_f * 0.7
      limit_transaction = Transaction.create(category: Transaction::CATEGORY[:pay_per_view],
                                             amount: amount,
                                             owner: true,
                                             transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
                                             direction: Transaction::DIRECTION[:credit],
                                             wallet_id: @limit.user.wallet.id,
                                             status: Transaction::STATUS[:pending],
                                             user_id: @limit.user.id
      )
      if limit_transaction
        check_upline_reward(@limit)
        give_upline_reward current_user, Setting.ppv_amount.to_f, Transaction::CATEGORY[:pay_per_view]
      end
      # @limit.user.wallet.update(balance: @limit.user.wallet.balance + limit_transaction.amount)
      render json: { status: true, ppv: @limit.ppv }
    else
      render json: { status: false }
    end
  end

  def ppv2
    if current_user.boost? and @limit.ppv2 < Setting.ppv2_boost_limit.to_i
      work = true
    elsif @limit.ppv2 < Setting.ppv2_limit.to_i
      work = true
    else
      work = false
    end
    if work
      @limit.update(ppv2: @limit.ppv2 + 1)
      amount = Setting.ppv2_amount.to_f * 0.7
      limit_transaction = Transaction.create(category: Transaction::CATEGORY[:pay_per_view],
                                             amount: amount,
                                             owner: true,
                                             transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
                                             direction: Transaction::DIRECTION[:credit],
                                             wallet_id: @limit.user.wallet.id,
                                             status: Transaction::STATUS[:pending],
                                             user_id: @limit.user.id
      )
      if limit_transaction
        check_upline_reward(@limit)
        give_upline_reward current_user, Setting.ppv2_amount.to_f, Transaction::CATEGORY[:pay_per_view]
      end
      # @limit.user.wallet.update(balance: @limit.user.wallet.balance + limit_transaction.amount)
      render json: { status: true, ppv2: @limit.ppv2 }
    else
      render json: { status: false }
    end
  end

  def ppi
    if @limit.update(ppi: @limit.ppi + 1)
      amount = Setting.ppi_amount.to_f * 0.7
      limit_transaction = Transaction.create(category: Transaction::CATEGORY[:pay_per_install],
                                             amount: amount,
                                             owner: true,
                                             transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
                                             direction: Transaction::DIRECTION[:credit],
                                             status: Transaction::STATUS[:pending],
                                             user_id: @limit.user.id,
                                             wallet_id: @limit.user.wallet.id
      )
      if limit_transaction
        give_upline_reward current_user, Setting.ppi_amount.to_f, Transaction::CATEGORY[:pay_per_install]
      end
      # @limit.user.wallet.update(balance: @limit.user.wallet.balance + limit_transaction.amount)
      render json: { status: true, ppi: @limit.ppi }
    else
      render json: { stauts: false }
    end
  end

  private

  def check_upline_reward(limit)
    if current_user.refer_income === 1
      boost = current_user.boost
      if boost
        ppc = Setting.ppc_boost_limit
        ppv = Setting.ppv_boost_limit
      else
        ppc = Setting.ppc_limit
        ppv = Setting.ppv_limit
      end
      if limit.ppc === ppc.to_i and limit.ppv === ppv.to_i
        real_sponsor = current_user.real_sponsor
        transaction = Transaction.create!(
            category: Transaction::CATEGORY[:pay_per_refer],
            amount: Setting.refer_amount,
            transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
            status: Transaction::STATUS[:approved],
            owner: true,
            user: real_sponsor,
            wallet: real_sponsor.wallet,
            direction: Transaction::DIRECTION[:credit],
            from: current_user
        )
        real_sponsor.wallet.update(balance: real_sponsor.wallet.balance + transaction.amount)
        currrent_user.update(refer_income: 0)
      end
    end
  end

  def get_limit
    @limit = Limit.where('created_at >= ? AND user_id = ?', Date.today, current_user.id).last
    unless @limit
      @limit = Limit.create(user_id: current_user.id)
    end
  end

  def give_upline_reward(user, o_amount, category)
    count = 0
    reward_per = [7.5, 6.0, 4.5, 3.0, 2.5, 2.0, 1.5, 1.25, 1.0, 0.75]
    while user.sponsor != nil
      amount = o_amount * (reward_per[count] / 100)
      Transaction.create!(
          category: category,
          amount: amount,
          owner: false,
          transaction_type: Transaction::TRANSACTION_TYPE[:wallet],
          direction: Transaction::DIRECTION[:credit],
          status: Transaction::STATUS[:pending],
          user_id: user.sponsor.id,
          wallet_id: user.sponsor.wallet.id,
          percent: reward_per[count],
          from: current_user
      )
      # t.user.wallet.update(balance: t.user.wallet.balance + t.amount)
      user = user.sponsor
      count += 1
      if count == 9
        break
      end
    end
  end
end
