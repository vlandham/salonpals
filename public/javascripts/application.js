jQuery(document).ready(function($) {
  $("#language-button").click(function() {
    $("#language-selection").toggle();
  });
  
  if ($(".notice").length) {
    $(".notice").delay("2000").slideUp("slow")
  }
  
   $(".formatted-text").cleditor({
     width:        500,
     height:       250,
     controls: 
      "bold italic underline | size style | " +
      "color highlight removeformat | bullets numbering | outdent " +
      "indent | alignleft center alignright justify | undo redo | " +
      "rule | cut copy paste"
     
   });
});