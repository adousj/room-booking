
$ ->

  # $('.btn-delete').hide()

  # btn_delete_hover_in = -> $(this).find(".btn-delete").fadeIn()
  # btn_delete_hover_out = -> $(this).find('.btn-delete').fadeOut()
  # $('tr').hover btn_delete_hover_in, btn_delete_hover_out

  # empty_color = '#ECF0F1'
  # chosen_color = '#D35400'
  # neighbour_color = '#F39C12'
  # hover_color = neighbour_color
  # hover_neighbour_color = '#F1C40F'
  # start_date = $("#datepicker").attr('data-start-date')
  # end_date = $('#datepicker').attr('data-end-date')
  # current_date = $('#datepicker').attr('data-date')

  # $('#datepicker')
  #   .datepicker({
  #     format: "yyyy-mm-dd",
  #     todayBtn: "linked",
  #     language: "zh-CN",
  #     todayHighlight: true,
  #     startDate: start_date,
  #     endDate: end_date
  #   })
  #   .on 'changeDate', (e)->
  #     y = e.date.getFullYear()
  #     m = e.date.getMonth() + 1
  #     m = '0' + m if m<10
  #     d = e.date.getDate()
  #     d = '0' + d if d<10
  #     date_picked = y + '-' + m + '-' + d
  #     $('#room-table caption a#table-date').text(date_picked)
  #     # $('#datepicker').datepicker('remove')
  #     $('#myModal').modal('hide')
  #     window.location = '/day/' + date_picked

  # table_td_hover_in = ->
  #   unless $(this).hasClass('chosen') or $(this).hasClass('neighbour')
  #     data_id = $(this).attr('data-id') - 0
  #     $(this).css('background-color', hover_color)
  #     $('#room-table td.table-item[data-id="'+(data_id-10)+'"]:not(.chosen):not(.neighbour)').css('background-color', hover_neighbour_color)
  #     $('#room-table td.table-item[data-id="'+(data_id+10)+'"]:not(.chosen):not(.neighbour)').css('background-color', hover_neighbour_color)

  # table_td_hover_out = ->
  #   unless $(this).hasClass('chosen') or $(this).hasClass('neighbour')
  #     data_id = $(this).attr('data-id') - 0
  #     $(this).css('background-color', empty_color)
  #     $('#room-table td.table-item[data-id="'+(data_id-10)+'"]:not(.chosen):not(.neighbour)').css('background-color', empty_color)
  #     $('#room-table td.table-item[data-id="'+(data_id+10)+'"]:not(.chosen):not(.neighbour)').css('background-color', empty_color)

  # $('#room-table td.table-item').hover table_td_hover_in, table_td_hover_out


  # $('#room-table .table-item').bind 'click', (e)->
  #   data_id = $(this).attr('data-id') - 0
  #   if $(this).hasClass('chosen') or $(this).hasClass('neighbour')
  #     $('#appModal').modal { backdrop:'static' ,keyboard: false }

  #     chosen_id = $('#room-table td.table-item.chosen').attr('data-id') - 0
  #     room_id = data_id % 10
  #     min_t = Math.floor Math.min [data_id/10, chosen_id/10]...
  #     max_t = Math.floor Math.max [data_id/10+1, chosen_id/10+1]...
  #     $('.modal-body input[name=room_id]').val 'room'+room_id
  #     $('.modal-body input[name=time]').val current_date+'  '+min_t+':00 ~ '+max_t+':00'
  #     $('.modal-body input[name=start_at]').val current_date+'  '+min_t+':00'
  #     $('.modal-body input[name=end_at]').val current_date+'  '+max_t+':00'

  #   else
  #     data_id = $(this).attr('data-id') - 0
  #     $('#room-table td.chosen').css('background-color', empty_color).removeClass('chosen')
  #     $('#room-table td.neighbour').css('background-color', empty_color).removeClass('neighbour')

  #     $(this).css('background-color', chosen_color).addClass('chosen')
  #     $('#room-table td.table-item[data-id="'+(data_id-10)+'"]').css('background-color', neighbour_color).addClass('neighbour')
  #     $('#room-table td.table-item[data-id="'+(data_id+10)+'"]').css('background-color', neighbour_color).addClass('neighbour')
    
      
  $('.msg-switch').on 'change', ->
    tr_row = $(this).closest('tr')
    msg_id = $(tr_row).attr('data-msg-id')
    msg_is_read = !$(this).bootstrapSwitch('status')
    $.ajax {
      type: 'POST'
      url: '/messages/is_read'
      data: { msg_id: msg_id, is_read: msg_is_read }
      dataType: 'json'
      error: (e)-> $(this).bootstrapSwitch('setState', msg_is_read)
      success: (e)->
        # console.log $(this).closest('tr')
        if msg_is_read
          $(tr_row).addClass('success').removeClass('error')
          # $(tr_row).slideUp()
          # $(tr_row).slideDown('slow').prependTo('tbody#read-msg')#.fadeIn()
          # $(tr_row).animate {left: '200px'}#, ->
          #   $(tr_row).animate {down: '50px'}, ->
          #     $(tr_row).prependTo('tbody#read-msg').animate {right: '10px'}, ->
          #       $(tr_row).animate {left: '5px'}
          # $(tr_row).slideDown('slow').fadeOut 'slow', ->
          #   $(tr_row).prependTo('tbody#read-msg').show("slow")
          $(tr_row).slideUp().prependTo('tbody#read-msg').slideDown()

        else
          $(tr_row).addClass('error').removeClass('success')
          $(tr_row).slideUp('slow').appendTo('tbody#unread-msg').slideDown('slow')
    }
