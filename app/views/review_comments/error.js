// alert("<%=@review_comment.errors[:no_comment] %>")
$("<%= escape_javascript(render partial: 'error') %>").fadeIn(1000).insertBefore($('#comments')).delay(2000).fadeOut(500)
