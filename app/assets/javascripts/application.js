// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-datepicker
//= require jquery_ujs
//= require jquery.raty
//= require ratyrate
//= require turbolinks
//= require_tree .

var flash = function(){
  setTimeout(function(){
    $('.alert').slideUp(500);
  }, 2000);
};

$(document).ready(flash);
$(document).on('page:load', flash);
$(document).on('page:change', flash);

var datepicker = function(){
  $(document).on('focus', '.datepicker', function(){
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true,
      todayHighlight: true
   });
  });
};
$(document).ready(datepicker);
$(document).on('page:load', datepicker);
$(document).on('page:change', datepicker);

document.addEventListener("turbolinks:load", function() {
  function myFunction(id) {
      var x = document.getElementById(id);
      if (x.className.indexOf("w3-show") == -1) {
          x.className += " w3-show";
          x.previousElementSibling.className += " w3-theme-d1";
      } else {
          x.className = x.className.replace("w3-show", "");
          x.previousElementSibling.className =
          x.previousElementSibling.className.replace(" w3-theme-d1", "");
      }
  }

  function openNav() {
      var x = document.getElementById("navDemo");
      if (x.className.indexOf("w3-show") == -1) {
          x.className += " w3-show";
      } else {
          x.className = x.className.replace(" w3-show", "");
      }
  }

  $.each($('#text'), function() {
    var offset = this.offsetHeight - this.clientHeight;
    var resizeTextarea = function(el) {
      $(el).css('height', 'auto').css('height', el.scrollHeight + offset);
    };
    $(this).on('keyup input', function() { resizeTextarea(this); }).removeAttr('data-autoresize');
  })
});

function myFunction(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
        x.previousElementSibling.className += " w3-theme-d1";
    } else {
        x.className = x.className.replace("w3-show", "");
        x.previousElementSibling.className =
        x.previousElementSibling.className.replace(" w3-theme-d1", "");
    }
}

function openNav() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}
