# encoding: utf-8
class ActiveSupport::TimeWithZone
  def my_format_time
    self.strftime('%Y/%m/%d %H:%M')
  end
end