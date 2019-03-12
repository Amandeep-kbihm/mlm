class Admin::EcpmController < Admin::BaseController
  before_action :authenticate_user!

  def new
    @ecpm = EcpmRecord.new
  end

  def index
    @ecpms = EcpmRecord.all.paginate(page: params[:page], per_page: 15).order(id: :desc)
  end

  def create
    @ecpm_record = EcpmRecord.new(ecpm_params)
    @transactions_id = Transaction.where('status = ? && category = ? && DATE(created_at) = ?',
                                         Transaction::STATUS[:pending],
                                         @ecpm_record.transaction_category,
                                         @ecpm_record.transaction_date).pluck(:id)
    if @ecpm_record.present? || @transactions_id.present?

      if @ecpm_record.ecpm_value < @ecpm_record.ecpm_min
        @ecpm_price = @ecpm_record.ecpm_value.to_f
      elsif @ecpm_record.ecpm_value > @ecpm_record.ecpm_min || @ecpm_record.ecpm_value < @ecpm_record.ecpm_max
        @ecpm_price = @ecpm_record.ecpm_min.to_f
      elsif @ecpm_record.ecpm_value > @ecpm_record.ecpm_min || @ecpm_record.ecpm_value > @ecpm_record.ecpm_max
        @ecpm_price = @ecpm_record.ecpm_max.to_f
      else
        @ecpm_price = @ecpm_record.ecpm_value.to_f
      end

      case @ecpm_record.transaction_category.to_i
        when 3
          base_amount = Setting.ppc_amount.to_f
        when 2
          base_amount = Setting.ppv_amount.to_f
        when 1
          base_amount = Setting.ppi_amount.to_f
        else
          base_amount = 0
      end

      @ecpm_record.select_ecpm_value = @ecpm_price
      @transactions_id.each do |value|
        @transaction = Transaction.find(value)

        if @transaction.owner
          amount = base_amount * 0.7
        else
          amount = base_amount * (@transaction.percent.to_f / 100)
        end

        @wallet = Wallet.find(@transaction.wallet_id)
        @transaction.update(status: Transaction::STATUS[:approved], amount: amount)
        @wallet.update(balance: @wallet.balance + amount)
      end
      if @ecpm_record.save
        redirect_to :back, notice: 'Successfully'
      else
        redirect_to :back, notice: 'ECPM Error!'
      end
    else
      redirect_to :back, error: 'No Record'
    end

  end

  def delete
    @ecpm = EcpmRecord.find_by_id(params[:id])
    if @ecpm.present?
      if @ecpm.delete
        redirect_to admin_ecpm_records_path, notice: 'Successfully Delete'
      else
        redirect_to admin_ecpm_records_path, alert: 'Error!'
      end
    else
      redirect_to admin_ecpm_records_path, alert: 'No record exist'
    end
  end

  private

  def ecpm_params
    params.require(:ecpm_record).permit(:transaction_date, :transaction_count, :transaction_category,
                                        :ecpm_value, :ecpm_min, :ecpm_max, :select_ecpm_value)
  end
end
