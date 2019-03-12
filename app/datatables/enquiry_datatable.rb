class EnquiryDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: 'Enquiry.id', cond: :eq },
      subject: { source: 'Enquiry.subject', cond: :like },
      enquiry: { source: 'Enquiry.enquiry' },
      mobile_number: { source: 'User.mobile_number' },
      status: { source: 'Enquiry.status' },
      date: { source: 'Enquiry.created_at' }
    }
  end

  def data
    records.map do |record|
      mobile = ''
      mobile = record.user.mobile_number if record.user
      {
          id: record.id,
          subject: record.subject,
          enquiry: record.enquiry,
          mobile_number: mobile,
          status: Enquiry::STATUS_REVERSE[record.status],
          date: record.created_at
      }
    end
  end

  private

  def get_raw_records
    Enquiry.all.order(id: :desc)
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
