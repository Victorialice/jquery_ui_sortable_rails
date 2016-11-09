var ua    = navigator.userAgent;
var isIE6 = ua.indexOf("MSIE 6") != -1;

;(function($){
  $.fn.delaySlider = function(options, fn){
    var parent      = $(this).find('.slide_box');
    var child       = parent.find('li');
    var childWidth  = child.outerWidth(true);
    var currentNum  = 0;
    var moveFlag    = false;
    var posX        = [];
    var check       = 0;
    var length      = 0;
    var firstChild  = child.filter(':first-child');
    var firstWidth  = firstChild.outerWidth();
    var firstLength = child.length;
    var visible     = Math.ceil(parent.innerWidth() / firstWidth);
    var timer;


    var defaults = {
      'speed'    : 400,
      'delay'    : 20,
      'easing'   : 'easeOutQuad',
      'gap'      : 0,
      'visible'  : visible,
      'autoplay' : false,
      'movetype' : 'left',
      'timer'    : 5
    };
    var setting = $.extend(defaults, options);

    var initPosition = function(){
      child.filter(':first').before(child.slice(0, setting.visible).clone(true).addClass('cloned'));
      child.filter(':last').after(child.slice(0, setting.visible).clone(true).addClass('cloned'));

      var clChild = parent.find('li');
      length      = clChild.length;

      parent.css({'width':(childWidth*length)+100, 'marginLeft':-(clChild.outerWidth(true)*firstLength + setting.gap) + 'px'});
      $(clChild).filter(':odd').addClass('odd');

      for(var i=0; i<length; i++){
        posX.push($(clChild[i]).position().left);
        $(clChild[i]).css({'left':posX[i]}).addClass('p' + i);

        check++;
        if(check == (length)){
          clChild.css({'position':'absolute'});
          //if(isIE6){ $(".png_img").fixPng(); }
        }
      }
    };
    initPosition();

    var action = function(index){
      var check2  = 0;
      var which   = index < currentNum ? 1 : -1;
      var reChild = parent.find('li');
      var first   = reChild.filter(':first');
      var last    = reChild.filter(':last');

      if(moveFlag == true) return;
      moveFlag = true;

      for(var i=0; i<length; i++){
        if(which == '-1'){
          var move = posX[i] - childWidth;
          $(reChild[i]).stop(true, true).delay(setting.delay * i).animate({'left':move}, setting.speed, setting.easing, function(){
            // moveFlag
            check2++;
            if(check2 == (length-1)){
              if(isIE6){
                //first.appendTo(parent).animate({'left':posX[length-1]}, 0, function(){
                  //reChild.find('img').hide();
                  //reChild.find('shape').remove();
                  //reChild.find('img').fixPng().show();
                //});
              }else {
                first.appendTo(parent).css({'left':posX[length-1]});
              }
              $.isFunction(fn) && fn.call(this);
              moveFlag = false;
            }
          });
        }else if(which == '1'){
          var move = posX[(length-1)-i] + childWidth;
          $(reChild[(length-1)-i]).stop(true, true).delay(setting.delay * i).animate({'left':move}, setting.speed, setting.easing, function(){
            // moveFlag
            check2++;
            if(check2 == (length-1)){
              if(isIE6){
                //last.prependTo(parent).animate({'left':posX[0]}, 0, function(){
                  //reChild.find('img').hide();
                  //reChild.find('shape').remove();
                  //reChild.find('img').fixPng().show();
                //});
              }else {
                last.prependTo(parent).css({'left':posX[0]});
              }
              $.isFunction(fn) && fn.call(this);
              moveFlag = false;
            }
          });
        }
      }
    };

    $(this).find('.nav_prev').on('click', function(){
      action(-1);
      setting.movetype = "right";
      clearInterval(timer);
      play();
      return false;
    });

    $(this).find('.nav_next').on('click', function(){
      action(1);
      setting.movetype = "left";
      clearInterval(timer);
      play();
      return false;
    });

    $(this).find('#photoSlide > li').hover(function (){
      clearInterval(timer);
      return false;
    }, function (){
      play();
      return false;
    });

    var play = function(){
      if(setting.autoplay == true){
        timer = setInterval(function(){
          if(setting.movetype == 'left'){ action(1); }
          else if(setting.movetype == 'right'){ action(-1); }
        },(setting.timer * 1000));
      }
    };

    play();
    return this;
  }
})(jQuery);
