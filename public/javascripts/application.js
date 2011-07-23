jQuery(document).ready(function($) {
  $("#language-button").click(function() {
    $("#language-selection").toggle();
  });
  
  if ($(".notice").length) {
    $(".notice").delay("2000").slideUp("slow")
  }
});