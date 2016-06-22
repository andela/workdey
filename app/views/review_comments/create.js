$("#comments").append("<%= escape_javascript(render partial: 'comment', locals: {comment: @review_comment}) %>")
$("#comment_body").val('')
