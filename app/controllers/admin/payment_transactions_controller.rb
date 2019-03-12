class Admin::PaymentTransactionsController < Admin::BaseController
  before_action :authenticate_user!

  def payment_type
    payment_transaction = PaymentTransaction.where('status = ? && payment_type = ?', params[:status], params[:type]).group('date(created_at)').select('SUM(amount) AS amount, date(created_at) AS date, COUNT(*) as count')
    @payment_transactions = payment_transaction.order('date DESC').paginate(page: params[:page], per_page:15)
  end

  def show_all
    payment_transaction = PaymentTransaction.where('status = ? && payment_type = ? && DATE(created_at) = ?', params[:status], params[:type], params[:date].to_date)
    @payment_transactions = payment_transaction.paginate(page: params[:page], per_page:15).order(id: :desc)
  end

  def payment_approved
    @payment_transaction = PaymentTransaction.find_by_id(params[:id])
    if @payment_transaction.present?
      if @payment_transaction.transaction_type == PaymentTransaction::PAYMENT_TYPE[:recharge]
        pt = @payment_transaction
        # HTTParty.get "https://joloapi.com/api/recharge.php?mode=1&userid=tousif745&key=425567080748520&operator=#{pt.operator}&service=#{pt.mobile_number}&amount=#{pt.amount.to_i}&orderid=#{pt.id}&type=json"
      end
      if @payment_transaction.update(status: PaymentTransaction::STATUS[:approved])
        redirect_to :back, notice: 'Payment Transaction Approved Successfully'
      else
        redirect_to :back, alert: 'Error!'
      end
    else
      redirect_to :back, notice: 'No Payment Transaction found'
    end
  end

  def decline
    @payment_transaction = PaymentTransaction.find_by_id params[:id]
    if @payment_transaction and @payment_transaction.status == PaymentTransaction::STATUS[:pending]
      @payment_transaction.update(status: PaymentTransaction::STATUS[:unapproved])
      wallet = @payment_transaction.user.wallet
      wallet.update(balance: wallet.balance + @payment_transaction.amount)
      redirect_to(:back, notice: 'Payment Transaction Declined. Amount credited') and return
    end
    redirect_to :back, notice: 'Can\'t find Payment Transaction'
  end

  def index
  end

  def show_transactions
    @user = params[:user_id]
    respond_to do |format|
      format.html
      format.json { render json: PaymentTransactionDatatable.new(view_context) }
    end
  end


end
