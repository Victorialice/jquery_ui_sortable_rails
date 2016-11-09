$(function (){
  //tooltip
  $('[rel="tooltip"],[data-rel="tooltip"]').tooltip({"placement":"bottom",delay: { show: 400, hide: 200 }});

  //点击展示，隐藏
  $('.btn-minimize').click(function(e){
    e.preventDefault();
    var $target = $(this).parent().parent().next('.box-content');
    if($target.is(':visible')) $('i',$(this)).removeClass('icon-chevron-up').addClass('icon-chevron-down');
    else 					   $('i',$(this)).removeClass('icon-chevron-down').addClass('icon-chevron-up');
    $target.slideToggle();
  });

  //首页图片上传
  $('#topimage_btn_ok').click(function (){
    if ($('#topimage_upload').val() === ''){
      alert('请选择上传的图片文件!');
      return false;
    }
    if ($.trim($('#ti_linkurl').val()) === ''){
      alert('请输入图片的链接地址!');
      return false;
    }
    $('#loadering').removeClass('hidden');
    $('#txt_tip').addClass('hidden');
    $('#ti_upload_form').submit();
  });
});

function ajax_image_cb(opts){
  if (opts.msg === 'ok'){
    $('#loadering').addClass('hidden');
    $('#txt_tip').text('上传成功!').removeClass('hidden');
    $('#ti_linkurl').val('');
    $('#topimage_upload').val('');
    var html = Mustache.render($('#topimage_index_tp').html(), opts);
    $('#render_topimage').prepend(html);
  } else {
    alert('上传失败!请重新上传');
    return false;
  }
}

function delete_resource(route, itemid){
  if(confirm('Delete? Ara you sure?')){
    $.ajax({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      type: 'delete',
      url: '/admin/'+route+'/'+itemid,
      async: false,
      dataType: 'json',
      success: function(data){
        if(data.msg === 'ok'){
          $('#'+route+'_'+itemid).remove();
        }
      }
    });
  }
  return false;
}