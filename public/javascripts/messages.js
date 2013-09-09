(function() {
  $(function() {
    return $('.msg-switch').on('change', function() {
      var msg_id, msg_is_read, tr_row;
      tr_row = $(this).closest('tr');
      msg_id = $(tr_row).attr('data-msg-id');
      msg_is_read = !$(this).bootstrapSwitch('status');
      return $.ajax({
        type: 'POST',
        url: '/messages/is_read',
        data: {
          msg_id: msg_id,
          is_read: msg_is_read
        },
        dataType: 'json',
        error: function(e) {
          return $(this).bootstrapSwitch('setState', msg_is_read);
        },
        success: function(e) {
          if (msg_is_read) {
            $(tr_row).addClass('success').removeClass('error');
            return $(tr_row).slideUp().prependTo('tbody#read-msg').slideDown();
          } else {
            $(tr_row).addClass('error').removeClass('success');
            return $(tr_row).slideUp('slow').appendTo('tbody#unread-msg').slideDown('slow');
          }
        }
      });
    });
  });
}).call(this);
