class Admin::TransactionsController < Admin::BaseController
  before_action :authenticate_user!

  def transaction_status
    transactions_own = Transaction.where('status = ? && category = ? && owner = 1', params[:status], params[:category]).group('date(created_at)').select('SUM(amount) AS amount, date(created_at) AS date, COUNT(*) as count')
    transactions_upline = Transaction.where('status = ? && category = ? && owner = 0', params[:status], params[:category]).group('date(created_at)').select('SUM(amount) AS amount, date(created_at) AS date, COUNT(*) as count')
    @transactions_own = transactions_own.order('date DESC').paginate(page: params[:page], per_page: 15)
    @transactions_upline = transactions_upline.order('date DESC').paginate(page: params[:page], per_page: 15)
  end

  def show
    @transactions = Transaction.where('status = ? && category = ? && DATE(created_at) = ?', params[:status], params[:category], params[:date].to_date)
    @results = @transactions.paginate(page: params[:page], per_page:15).order(id: :desc)
  end

  def refund
    @transaction = Transaction.new
    @user = params[:user_id]
  end

  def deduct
    @transaction = Transaction.new
    @user = params[:user_id]
  end

  def deduct_post
    @user = User.find_by_id params[:user_id]
    @transaction = Transaction.new(refund_params)
    @transaction.category = Transaction::CATEGORY[:deduct]
    @transaction.user = @user
    @transaction.wallet = @user.wallet
    @transaction.direction = Transaction::DIRECTION[:debit]
    @transaction.owner = true
    if @transaction.save
      @user.wallet.update(balance: @user.wallet.balance - @transaction.amount)
      redirect_to admin_user_details_path
    end
  end

  def refund_post
    @user = User.find_by_id params[:user_id]
    @transaction = Transaction.new(refund_params)
    @transaction.category = Transaction::CATEGORY[:refund]
    @transaction.user = @user
    @transaction.wallet = @user.wallet
    @transaction.direction = Transaction::DIRECTION[:credit]
    @transaction.owner = true
    if @transaction.save
      @user.wallet.update(balance: @user.wallet.balance + @transaction.amount)
      redirect_to admin_user_details_path
    end
  end

  private

  def refund_params
    params.require(:transaction).permit(:amount)
  end
end
