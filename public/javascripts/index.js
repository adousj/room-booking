
$(function() {
  var chosen_color, current_date, empty_color, end_date, hover_color, hover_neighbour_color, neighbour_color, start_date, table_td_hover_in, table_td_hover_out;
  empty_color = '#ECF0F1';
  chosen_color = '#D35400';
  neighbour_color = '#F39C12';
  hover_color = neighbour_color;
  hover_neighbour_color = '#F1C40F';
  start_date = $("#datepicker").attr('data-start-date');
  end_date = $('#datepicker').attr('data-end-date');
  current_date = $('#datepicker').attr('data-date');
  $('#datepicker').datepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    language: "zh-CN",
    todayHighlight: true,
    startDate: start_date,
    endDate: end_date
  }).on('changeDate', function(e) {
    var d, date_picked, m, y;
    y = e.date.getFullYear();
    m = e.date.getMonth() + 1;
    if (m < 10) m = '0' + m;
    d = e.date.getDate();
    if (d < 10) d = '0' + d;
    date_picked = y + '-' + m + '-' + d;
    $('#room-table caption a#table-date').text(date_picked);
    $('#myModal').modal('hide');
    return window.location = '/day/' + date_picked;
  });
  table_td_hover_in = function() {
    var data_id;
    if (!($(this).hasClass('chosen') || $(this).hasClass('neighbour'))) {
      data_id = $(this).attr('data-id') - 0;
      $(this).css('background-color', hover_color);
      $('#room-table td.table-item[data-id="' + (data_id - 10) + '"]:not(.chosen):not(.neighbour)').css('background-color', hover_neighbour_color);
      return $('#room-table td.table-item[data-id="' + (data_id + 10) + '"]:not(.chosen):not(.neighbour)').css('background-color', hover_neighbour_color);
    }
  };
  table_td_hover_out = function() {
    var data_id;
    if (!($(this).hasClass('chosen') || $(this).hasClass('neighbour'))) {
      data_id = $(this).attr('data-id') - 0;
      $(this).css('background-color', empty_color);
      $('#room-table td.table-item[data-id="' + (data_id - 10) + '"]:not(.chosen):not(.neighbour)').css('background-color', empty_color);
      return $('#room-table td.table-item[data-id="' + (data_id + 10) + '"]:not(.chosen):not(.neighbour)').css('background-color', empty_color);
    }
  };
  $('#room-table td.table-item').hover(table_td_hover_in, table_td_hover_out);
  return $('#room-table .table-item').bind('click', function(e) {
    var chosen_id, data_id, max_t, min_t, room_id;
    data_id = $(this).attr('data-id') - 0;
    console.log(0);
    if ($(this).hasClass('chosen') || $(this).hasClass('neighbour')) {
      console.log(1);
      $('#appModal').modal({
        backdrop: 'static',
        keyboard: false
      });
      chosen_id = $('#room-table td.table-item.chosen').attr('data-id') - 0;
      room_id = data_id % 10;
      min_t = Math.floor(Math.min.apply(Math, [data_id / 10, chosen_id / 10]));
      max_t = Math.floor(Math.max.apply(Math, [data_id / 10 + 1, chosen_id / 10 + 1]));
      $('.modal-body input[name=room_id]').val('room' + room_id);
      $('.modal-body input[name=time]').val(current_date + '  ' + min_t + ':00 ~ ' + max_t + ':00');
      $('.modal-body input[name=start_at]').val(current_date + '  ' + min_t + ':00');
      return $('.modal-body input[name=end_at]').val(current_date + '  ' + max_t + ':00');
    } else {
      console.log(2);
      data_id = $(this).attr('data-id') - 0;
      $('#room-table td.chosen').css('background-color', empty_color).removeClass('chosen');
      $('#room-table td.neighbour').css('background-color', empty_color).removeClass('neighbour');
      $(this).css('background-color', chosen_color).addClass('chosen');
      $('#room-table td.table-item[data-id="' + (data_id - 10) + '"]').css('background-color', neighbour_color).addClass('neighbour');
      return $('#room-table td.table-item[data-id="' + (data_id + 10) + '"]').css('background-color', neighbour_color).addClass('neighbour');
    }
  });


});
