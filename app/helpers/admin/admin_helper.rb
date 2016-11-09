# encoding: utf-8
module Admin::AdminHelper
  def menu_active(controller)
    (controller_name == controller) ? 'active' : nil
  end

  def icon(controller)
    (controller_name == controller) ? 'icon-white' : nil
  end

  def bias_time(time)
    return nil unless time
    time.strftime('%Y/%m/%d %H:%M')
  end

end