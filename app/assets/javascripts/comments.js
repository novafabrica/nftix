$(document).ready(function() {

  $('form.comment_form').ajaxify_form('POST', function(node, response, textStatus){
    node.find('#comment_content').val('');
    var $comment = $(response['html']);
    bindCommentEvents($comment);
    $('#comments').append($comment);
  });

  $('.comment .delete').ajaxify_link({method: "DELETE"}, deleteComment);

  $('.comment .edit').ajaxify_link({method: "GET"}, editComment);


});

function deleteComment(link){
  $(link).closest('.comment').remove();
}


function editComment(link, response){
  var $comment = $(link).closest('.comment');
  var $oldComment = $comment.clone();
  var $form = $(response['html']);
  $form.find('.cancel-comment-edit').click(
    function() {
    $comment.html($oldComment.html());
    bindCommentEvents($comment);
    return false;
    }
  );
  $form.ajaxify_form('PUT', function(node, response, textStatus){
    var $newComment = $(response['html']);
    bindCommentEvents($newComment);
    $comment.replaceWith($newComment);
  });
  $comment.html($form);
}

function bindCommentEvents($comment) {
  $comment.find('.edit').ajaxify_link({method: "GET"}, editComment);
  $comment.find('.delete').ajaxify_link({method: "DELETE"}, deleteComment);
}

