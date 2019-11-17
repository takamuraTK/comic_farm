module NewlysHelper
  def get_month_str(month)
    month.in_time_zone.strftime('%Y年%m月')
  end

  def get_pre_month_str(month)
    month.in_time_zone.prev_month.strftime('%Y年%m月')
  end
end