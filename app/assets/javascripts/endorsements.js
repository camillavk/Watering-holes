$(document).ready(function() {

  $('.endorsements_link').on('click', function(event) {
    event.preventDefault();

    var endorsementCount = $(this).siblings('.endorsements_count');
    //  var url = $(this).attr('href');

    $.post(this.href, function(response) {
      // $(this).siblings('.endorsements_count').text(response.new_endorsement_count);
      endorsementCount.text(response.new_endorsement_count);
    });
  });

});
