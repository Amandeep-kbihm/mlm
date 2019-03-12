class Api::V1::PaymentTransactionsController <  Api::BaseController

  def transaction_by_paytm
    @user = current_user
    @type = PaymentTransaction::PAYMENT_TYPE[:paytm]
    @payment_params = payment_transactions_params
    @wallet_balance = @user.wallet.balance
    @withdrawal_amount = @payment_params[:amount].to_f
    if @payment_params[:amount].to_f.nil? || @payment_params[:amount].to_f <= 0
      render json: { message: 'Amount cannot be blank or zero', status: false }
    elsif @payment_params[:mobile_number].empty?
      render json: { message: 'Mobile Number cannot be blank', status: false }
    else
      if @wallet_balance < 700
        render json: { status: false, message: 'Insufficient amount' }
      elsif @wallet_balance - 200 >= @withdrawal_amount
        PaymentTransaction.create(user_id:@user.id, wallet_id:@user.wallet.id,
                                  amount: @withdrawal_amount, status:PaymentTransaction::STATUS[:pending],
                                  pan_number:@payment_params[:pan_number], direction:PaymentTransaction::DIRECTION[:debit],
                                  name:@payment_params[:name], payment_type:@type, mobile_number: @payment_params[:mobile_number])
        @user.wallet.update(balance: @wallet_balance - @withdrawal_amount)
        render json: {status: true, message: 'Wait for approval'}
      else
        render json: { message: "You can only withdraw #{(@wallet_balance - 200)} amount", status: false }
      end
    end
  end

  def transaction_by_bank
    @user = current_user
    @type = PaymentTransaction::PAYMENT_TYPE[:bank_transaction]
    @payment_params = bank_transactions_params
    @wallet_balance = @user.wallet.balance
    @withdrawal_amount = @payment_params[:amount].to_f
    if @payment_params[:amount].to_f.nil? || @payment_params[:amount].to_f <= 0
      render json: { message: 'Amount cannot be blank or zero', status: false}
    elsif @payment_params[:mobile_number].empty?
      render json: { message: 'Mobile Number cannot be blank', status: false}
    elsif @payment_params[:name].empty?
      render json: { message: 'Bank Holder Name cannot be blank', status: false}
    elsif @payment_params[:bank_account].empty?
      render json: { message: 'Bank Account cannot be blank', status: false}
    elsif @payment_params[:ifsc].empty?
      render json: { message: 'IFSC CODE cannot be blank', status: false}
    elsif @payment_params[:pan_number].empty?
      render json: { message: 'Pan Number cannot be blank', status: false}
    else
      if @wallet_balance < 1000
        render json: { status: false, message: 'Insufficient amount' }
      elsif @wallet_balance - 300 >= @withdrawal_amount
        PaymentTransaction.create(user_id: @user.id,
                                  wallet_id: @user.wallet.id,
                                  amount: @withdrawal_amount,
                                  status: PaymentTransaction::STATUS[:pending],
                                  pan_number: @payment_params[:pan_number],
                                  direction: PaymentTransaction::DIRECTION[:debit],
                                  bank_account: @payment_params[:bank_account],
                                  ifsc: @payment_params[:ifsc],
                                  name: @payment_params[:name],
                                  address: @payment_params[:address],
                                  payment_type: @type,
                                  mobile_number: @payment_params[:mobile_number])
        @user.wallet.update(balance: @wallet_balance - @withdrawal_amount)
        render json: { status: true, message: 'Wait for approval' }
      else
        render json: { message: "You can only withdraw #{(@wallet_balance  - 300)} amount", status: false }
      end
    end
  end


  def transaction_by_recharge
    @user = current_user
    @type = PaymentTransaction::PAYMENT_TYPE[:mobile_recharge]
    @wallet_balance = @user.wallet.balance
    @payment_params=  mobile_recharge_params
    @withdrawal_amount = @payment_params[:amount].to_f

    if @payment_params[:amount].to_f.nil? || @payment_params[:amount].to_f <= 0
      render json: { message: 'Amount cannot be blank or zero', status: false }
    elsif @payment_params[:number].to_s.empty?
      render json: { message: 'Mobile Number cannot be blank', status: false }
    elsif @payment_params[:operator].to_s.empty?
      render json: { message: 'Operator cannot be blank', status: false }
    else
      if @wallet_balance < 300
        render json: { status: false, message: 'Insufficient funds' }
      elsif (@wallet_balance - 200) >= @withdrawal_amount
        pt = PaymentTransaction.create(
            user_id: @user.id,
            wallet_id: @user.wallet.id,
            name: @user.name,
            amount: @withdrawal_amount,
            status: PaymentTransaction::STATUS[:pending],
            direction: PaymentTransaction::DIRECTION[:debit],
            operator: @payment_params[:operator],
            payment_type: @type,
            mobile_number: @payment_params[:number]
        )
        @user.wallet.update(balance: @wallet_balance - @withdrawal_amount)
        render json: { status: true, message: 'Wait for approval from admin' }
      else
        render json:{ message: "You can only do a recharge of #{(@wallet_balance - 200)}", status: false }
      end
    end
  end

  def recharge_operators
  end


  private

  def payment_transactions_params
    params.require(:payment_transactions).permit(:amount, :mobile_number)
  end

  def bank_transactions_params
    params.require(:payment_transactions).permit(:name, :ifsc, :bank_account, :pan_number, :amount, :mobile_number)
  end

  def mobile_recharge_params
    params.require(:mobile_recharge).permit(:operator, :number, :amount)
  end

end
