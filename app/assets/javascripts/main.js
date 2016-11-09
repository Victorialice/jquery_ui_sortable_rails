$(function () {

  //首页top图片展示滚动
  $('#photoContainer').delaySlider({
    'gap'      : -115,
    'autoplay' : true,
    'timer'    : 3
  });

  smartRollover('#top-header > li > a > img');
  smartRollover('#menu_03 img');

  $('#photoSlide li').hover(function (){
    $(this).addClass('img_opacity');
  }, function (){
    $(this).removeClass('img_opacity');
  });


//  $('ul.in_brand li p.brand1_left').on({
//    'mouseenter': function (){
//      $(this).find('img').stop().animate({top: 15},{duration: 100,easing: 'easeOutSine'}).animate({top: 28},{duration: 800,easing: 'easeOutBounce'});
//    },
//    'mouseleave': function (){}
//  });

  var _timer_header_toggle;
  var top_nav_first = true;
  $('.navArea').hover(function (){
    clearTimeout(_timer_header_toggle);
    $('#c_header').stop().animate({height: '127px'}, 400, 'easeOutQuint', function (){
    });

  }, function (){});

  $('#top-header').hover(function (){}, function (){
    _timer_header_toggle = setTimeout(function (){
      $('#top-header').find('.menu').stop(true, true).slideUp(200);
      $('#c_header').stop().animate({height: '90px'}, 400, 'easeOutQuint', function (){});
      top_nav_first = true;
    }, 800);
  });

  $('#top-header > li').mouseenter(function (){
    $(this).parent().find('.menu').hide();

    if(top_nav_first){
      $(this).find('> ul').stop(true, true).slideDown(200);
      top_nav_first = false;
    } else {
      $(this).find('>ul').show();
    }
  });

  $('.navCategory > li').hover(function (){
    $(this).find('.sub').stop(true, true).slideDown(200);
  }, function (){
    $(this).find('.sub').stop(true, true).slideUp(200);
  });

  $('#id_header_top').find('> p').hover(function (){
    $('#top-header').find('.menu').stop(true, true).slideUp(200);
    $('#c_header').stop().animate({height: '90px'}, 400, 'easeOutQuint', function (){});
    top_nav_first = true;
    $(this).find('img').attr('src', '/assets/web/menu01_on.gif');
  }, function (){
    $(this).find('img').attr('src', '/assets/web/menu01_off.gif');
  });


  $('#g_flv').click(function (){
    $.fancybox($('#flv_addr').html(), {
      maxWidth	: 720,
      maxHeight	: 408,
      autoSize	: false,
      openEffect	: 'none',
      closeEffect	: 'none'
    });
    return false;
  });

  //会员登录
  $('.member_logined').click(function (){
    $.fancybox($('#fancybox_login_tp').html(), {
      maxWidth	: 440,
      maxHeight	: 360,
      autoSize	: false,
      openEffect	: 'none',
      closeEffect	: 'none'
    });

    $('.fancybox-skin').addClass('fix-fancybox-skin');//fix fancybox css

    //点击登录按钮
    $('#member_logined_btn').on('click', function (){
      var p    = $('#member_login'),
          url  = p.attr('action'),
          name = $.trim(p.find('input[name="login"]').val()),
          pwd  = $.trim(p.find('input[name="password"]').val());
      if (name === ''){
        alert('邮箱不能为空!');
        return false;
      }else if (pwd === '') {
        alert('密码不能为空!');
        return false;
      }
      var remember_me = 0;
      if(p.find('input[name="remember_me"]:checked').length > 0) {
        remember_me = 1;
      }
      $.ajax({
        beforeSend: send_xhr(),
        type: 'post',
        url:  url,
        data: {name: name, password: pwd, rememberme: remember_me},
        async: false,
        dataType: 'json',
        success: function(data){
          if(data.msg === 'error'){
            alert('帐号或密码错误!请重新输入!');
            return false;
          } else {
            location.href = '/users/'+data.userid;
          }
        }
      });
      return false;
    });//点击登录按钮

    //点击忘记密码
    $('#forget_password').click(function (){
      $.fancybox($('#forget_password_tp').html(), {
        maxWidth	: 350,
        maxHeight	: 257,
        autoSize	: false,
        openEffect	: 'none',
        closeEffect	: 'none'
      });

      //点击提交按钮
      $('#forget_password_btn').click(function (){
        var prev  = $(this).prev(),
            email = $.trim(prev.val());

        if (email === '') {
          alert('请输入您在本站注册的Email地址!');
          return false;
        }

        $.ajax({
          beforeSend: function (){
            send_xhr();
            $('#fpb_tip').html('<img src="/assets/bx_loader.gif" /><span>正在发送邮件中...请稍后!</span>');
          },
          type: 'post',
          url:  '/users/forgot_pwd',
          data: {email: email},
          async: false,
          dataType: 'json',
          success: function(data){
            if(data.msg === 'ok'){
              $('#fpb_tip').html('');
              alert('重设密码邮件已发送到您的邮箱，请查看!');
              $.fancybox.close();
              return false;
            } else if (data.msg === 'error') {
              $('#fpb_tip').html('');
              alert('您还没有在本站注册过!');
              return false;
            }
            if(data.msg === "KO"){
              $('#fpb_tip').html('');
              alert('该邮箱帐号处于退会状态!');
              return false;
            }
          }
        });

        return false;
      });

    });//点击忘记密码


    return false;
  });

  //退出
  $('.quit').click(function (){
    $.ajax({
      beforeSend: send_xhr(),
      type: 'post',
      url:  '/sessions/destroy',
      async: false,
      dataType: 'json',
      success: function(data){
        if(data.msg === 'ok'){
          alert('成功退出!');
          location.href = '/';
        }
      }
    });
    return false;
  });

  //马上参加活动
  $('#rightnow_join').click(function (){
    $.fancybox($('#rightnow_sure_info').html(),{
      maxWidth	: 650,
      maxHeight	: 257,
      autoSize	: false,
      openEffect	: 'none',
      closeEffect	: 'none'
    });

    //点击确认
    $('#sure_join_campaign').click(function (){
      $.ajax({
        beforeSend: send_xhr(),
        type: 'post',
        url:  '/users/join_campaign',
        data: { campaign_id: $(this).attr('data-campaign-id') },
        async: false,
        dataType: 'json',
        success: function(data){
          if(data.success === 'yes'){
            alert('参与活动成功!');
            location.href = '/users/'+data.user_id;
          } else {
            alert('您已经参加过了此次活动!');
          }
        }
      });
      return false;
    });
    return false;
  });

  //活动列表
  $('#my_campagin_lists').find('> li').click(function (env){
    env.stopPropagation();
    var aid = $(this).attr('data-award-id');
    if ($('#award_list_'+aid).find('li').length === 0) {
      alert('暂时获奖名单还没有公布，请耐心等待!');
      return false;
    }
    $('#award_list_'+aid).slideToggle('slow', function (){
      if (this.style.display === 'none') {
        $(this).prev().find('li[data-award-id="'+aid+'"]').find('p:last').find('img').attr('src', '/assets/web/mypage_icon2_off.png');
      } else {
        $(this).prev().find('li[data-award-id="'+aid+'"]').find('p:last').find('img').attr('src', '/assets/web/mypage_icon2_on.png');
      }
    });
  });

  //活动页面视频播放
  $('.activity_series').find('> li').click(function (){
    var flv_link = $(this).find('p:first').find('a').attr('href');
    var html     = Mustache.render($('#activity_tp').html(), {url: flv_link});
    var width = 350;
    var height = 257;
    if ($(this).attr("id") == "except_li"){
      html  = Mustache.render($('#activity_tp_except').html(), {url: flv_link});
      width = 720;
      height = 408;
    }
    $.fancybox(html, {
      maxWidth	: width,
      maxHeight	: height,
      autoSize	: false,
      openEffect	: 'none',
      closeEffect	: 'none'
    });
    return false;
  });

  $('#first_activity, #first_activity_a, #first_activity_b, #first_activity_c').click(function (){
    var flv_link = "/flv/30s_add_sp.flv";
    var html     = Mustache.render($('#activity_tp_except').html(), {url: flv_link});
    $.fancybox(html, {
      maxWidth	: 720,
      maxHeight	: 408,
      autoSize	: false,
      openEffect	: 'none',
      closeEffect	: 'none'
    });
    return false;
  });

  $("#users_email1").blur(function(){
    //alert($(this).val().indexOf("@"));
    if($(this).val().indexOf("@") != -1){
      $.ajax({
        beforeSend: send_xhr(),
        type: 'get',
        url:  '/users/check_email',
        data: { email: $(this).val() },
        async: true,
        dataType: 'json',
        success: function(data){
          if(data.success === 'NG'){
            $("#email_ok").hide();
            $("#checked_info li").show().text(data.msg);
          } 
          if(data.success === 'OK'){
            $("#checked_info li").hide();
            $("#email_ok").show();
          } 
        }
      });
    }
  });

}); //$()

function send_xhr(){
  return function (xhr){
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  }
}
