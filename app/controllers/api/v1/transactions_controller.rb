class Api::V1::TransactionsController < Api::BaseController
  def unapproved
    transactions = Transaction.where(user: current_user, status: Transaction::STATUS[:unapproved]).group(:category).select('SUM(amount) amount, category')
    render json: {
        transactions: transactions
    }
  end

  def pending
    transactions = Transaction.where(user: current_user, status: Transaction::STATUS[:pending]).group(:category, :owner).select('SUM(amount) amount, category, owner')
    render json: {
        transactions: transactions
    }
  end

  def approved
    transactions = Transaction.where(user: current_user, status: Transaction::STATUS[:approved]).group(:category).select('SUM(amount) amount, category')
    render json: {
        transactions: transactions
    }
  end

end