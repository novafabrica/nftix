$(document).ready(function() {

  $('form.full-comment-form').ajaxify_form('POST', function(node, response, textStatus){
    node.find('#comment_content').val('');
    var $comment = $(response['html']);
    bindCommentEvents($comment);
    $('#comments').append($comment);
  });

  $('.comment .delete').ajaxify_link({method: "DELETE"}, deleteComment);

  $('.comment .edit').ajaxify_link({method: "GET"}, editComment);

  $('.new-comment .create').click(function() {
    toggelCommentForm($(this));
    return false;
  });

});

function toggelCommentForm(node) {
  var $form = node.siblings('form').show();
  $form.ajaxify_form('POST', function(node, response, textStatus){
    node.find('#comment_content').val('');
    var $comment = $(response['html']);
    bindCommentEvents($comment);
    node.parent().siblings('.right-column').find('.comments-on-index').append($comment);
    node.hide();
    node.unbind();
  });
  $form.find('.cancel-comment').click( function() {
    $form.hide();
    $form.unbind();
    return false;
  });
}

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

