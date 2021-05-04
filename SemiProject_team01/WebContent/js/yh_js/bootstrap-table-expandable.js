
    $(function () {
        $('table.table-expandable').each(function () {
            var table = $(this);
            table.children('tbody').children('tr.tr_content').hide(); // 테이블의 내용 숨기기
            table.children('tbody').children('tr.tr_title').click(function () { //타이틀 클릭시 작동하는 이벤트
                var element = $(this);
                element.next('tr').toggle('slow');
            });
        });
    });