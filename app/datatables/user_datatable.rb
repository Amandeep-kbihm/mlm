include Admin::UsersHelper
class UserDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: 'User.id', cond: :eq },
      name: { source: 'User.name', cond: :like },
      email: { source: 'User.email', cond: :like },
      mobile_number: { source: 'User.mobile_number', cond: :start_with },
      boost: { source: 'User.boost' },
      active: { source: 'User.status' },
      work: { source: 'User.limits', searchable: false },
      chain_count: { source: 'User.chain_count' },
      earning: { source: 'User.wallet.balance', searchable: false },
      refer_id: { source: 'User.refer_id' },
      sponsor_id: { source: 'User.sponsor_id' },
      links: { source: '' }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        email: record.email,
        mobile_number: record.mobile_number,
        boost: record.boost,
        active: record.status,
        work: get_limit.call(record),
        chain_count: record.chain_count,
        earning: record.wallet.balance,
        refer_id: record.refer_id,
        sponsor_id: record.sponsor_id,
        links: ''
      }
    end
  end

  private

  def get_limit
    date = DateTime.now
    ->(record) { return record.limits.select(:id, :ppi, :ppc, :ppv).where('created_at >= ?', DateTime.new(date.year, date.month, date.day)).last ? record.limits.select(:id, :ppi, :ppc, :ppv).where('created_at >= ?', DateTime.new(date.year, date.month, date.day)).last.to_json : 'No work' }
  end

  def get_links
    ->(record) { return get_links_for(record) }
  end

  def get_raw_records
    User.all.order(created_at: :desc)
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
