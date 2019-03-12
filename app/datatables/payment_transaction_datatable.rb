class PaymentTransactionDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: {source: 'PaymentTransaction.id', cond: :eq },
      amount: { source: 'PaymentTransaction.amount', cond: :eq },
      status: { source: 'PaymentTransaction.status', cond: :eq },
      mobile_number: { source: 'PaymentTransaction.mobile_number', cond: :eq },
      payment_type: { source: 'PaymentTransaction.payment_type', cond: :eq },
      created_at: { source: 'PaymentTransaction.created_at', cond: :eq }
    }
  end

  def data
    records.map do |record|
      {
        # example:
        id: record.id,
        amount: record.amount,
        status: record.status,
        mobile_number: record.mobile_number,
        payment_type: record.payment_type,
        created_at: record.created_at
      }
    end
  end

  private

  def get_raw_records
    PaymentTransaction.where(user_id: params[:user_id])
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
