$(function() {
  $('.js-settlement_status').on('change', function() {
    var store_id = $(this).data('id');
    var settlement_status = $(this).val();

    $.ajax({
      type: 'PATCH',
      url: '/stores/' + store_id + '/settlement_status',
      data: {
        store: {
          id: store_id,
          settlement_status: settlement_status
        }
      },
      dataType: 'json',
    })
    .done(function(data) {
      alert('【' + data.store_name + '】の決済ステータスを[' + data.settlement_status + ']に更新しました。');
    })
  });
});