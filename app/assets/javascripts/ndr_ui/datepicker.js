//= require bootstrap-datepicker-1.6.0-dist/js/bootstrap-datepicker

jQuery(document).ready(function(){
  // append inline warning block after `.input-group` block
  jQuery('.input-group[data-provide="datepicker"]').each(function(){
    jQuery(this).find(".help-block").insertAfter(jQuery(this));
  });
});