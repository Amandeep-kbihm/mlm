# @refers = @refers.map do |ru|
#   JSON.parse(ru.to_json(include: :refer))
# end
date = DateTime.now
json.users @refers do |refer|
  refer = refer.referred
  json.id refer.id
  json.name refer.name
  json.email refer.email
  json.refer_id refer.refer_id
  json.mobile_number refer.mobile_number
  json.work refer.limits.select(:id, :ppi, :ppc, :ppv).where('created_at >= ?', DateTime.new(date.year, date.month, date.day)).last ? refer.limits.select(:id, :ppi, :ppc, :ppv).where('created_at >= ?', DateTime.new(date.year, date.month, date.day)).last : { id: 0, ppi: 0, ppc: 0, ppv: 0 }
end