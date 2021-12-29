$(function() {
  $('.js-progress_status').on('change', function() {
    var store_id = $(this).data('id');
    var progress_status = $(this).val();

    $.ajax({
      type: 'PATCH',
      url: '/stores/' + store_id + '/progress_status',
      data: {
        store: {
          id: store_id,
          progress_status: progress_status
        }
      },
      dataType: 'json',
    })
    .done(function(data) {
      alert('【' + data.store_name + '】の進捗ステータスを[' + data.progress_status + ']に更新しました。');
    })
  });
});