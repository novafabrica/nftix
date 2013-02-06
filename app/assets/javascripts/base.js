$.ajaxSetup({
 'beforeSend': function(xhr) {
   xhr.setRequestHeader("Accept", "text/javascript");
   xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
   }
});

var autoCompleteVars = null;
var selectedComplete = null;
var typedValue = null;

// set a variable to detect if browser is IE8.
// Can be performed before the document is ready (faster).
var browser_is_ie8 = $.browser.msie && ( $.browser.version.substring(0, 2) == "8." || navigator.userAgent.indexOf('Trident') !== -1 );

$(document).ready(function() {


});

jQuery.fn.observe_field = function(frequency, callback) {

    frequency = frequency * 1000; // translate to milliseconds

    return this.each(function(){
      var $this = $(this);
      var prev = $this.val();

      var check = function() {
        var val = $this.val();
        hello =  $this;
        if((prev != val) && !($this.hasClass("inactive")) ){
          prev = val;
          $this.map(callback); // invokes the callback on $this
        }
      };

      var reset = function() {
        if(ti){
          clearInterval(ti);
          ti = setInterval(check, frequency);
        }
      };

      check();
      var ti = setInterval(check, frequency); // invoke check periodically

      // reset counter after user interaction
      $this.bind('keyup click mousemove', reset); //mousemove is for selects
    });

};

jQuery.fn.addValidation = function(validation) {
  this.keyup(function() {
    if(validation(this)) {
      $(this).parent().parent().removeClass("field_with_errors");
      $(this).siblings('input[type=submit]').attr({disabled: null});
    }
    else {
      $(this).parent().parent().addClass('field_with_errors');
      $(this).siblings('input[type=submit]').attr({disabled: 'disabled'});
    }
  });
  return this;
};
