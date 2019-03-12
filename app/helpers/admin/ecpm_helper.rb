module Admin::EcpmHelper

  def ecpm_calculate(ecpm_record)
    if ecpm_record.ecpm_value < ecpm_record.ecpm_min
      @ecpm_price = ecpm_record.ecpm_value
    elsif ecpm_record.ecpm_value > ecpm_record.ecpm_min || ecpm_record.ecpm_value < ecpm_record.ecpm_max
      @ecpm_price = ecpm_record.ecpm_min
    elsif ecpm_record.ecpm_value > ecpm_record.ecpm_min || ecpm_record.ecpm_value > ecpm_record.ecpm_max
      @ecpm_price = ecpm_record.ecpm_max
    end
  end
end
