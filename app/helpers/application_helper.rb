# encoding: utf-8
module ApplicationHelper

  #用户参加活动的三种显示状况
  #1.如果活动结束，不管用户有没有参加这个活动，都显示 “查看获奖名单”
  #2.如果还在活动的日期内。a.如果用户没有参加，则显示 "马上参与活动",b.如果用户参加了，则显示 "谢谢您的参加"
  def show_campaign_three_status
    campaign = @campaign || ::Campaign.latest_campaign[0]
    if campaign.over_date < Time.now.to_date
      '<a href="/presentation#here"><img src="/assets/web/mypage_icon1.gif" /></a>'.html_safe  #查看获奖名单
    else
      #查找这个用户是否参加了这次活动
      if current_user.is_join_campaign?(campaign.id)
        '<a href="javascript:;"><img src="/assets/web/mypage_icon1-3.gif" /></a>'.html_safe #谢谢您的参加
      else
        '<a href="/presentation" id="_rightnow_join"><img src="/assets/web/mypage_icon1-2.gif" /></a>'.html_safe #马上参与活动
      end
    end
  end

  def truncate_u(text, length = 30, truncate_string = '...')
    l = 0
    char_array = text.unpack('U*')
    char_array.each_with_index do |c, i|
      l = l + (c < 127 ? 0.5 : 1)
      if l >= length
        return char_array[0..i].pack('U*') + (i < char_array.length - 1 ? truncate_string : '')
      end
    end
    text
  end

end
