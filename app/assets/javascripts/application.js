// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require toastr
//= require_tree .
// $( document ).on('turbolinks:load', function() {
    // $(document).ready(function() {
    //   $('.alert').delay(2000).fadeOut();
    // });
// });

$(document).ready(function(){
    
    $('.rating').raty({
      mouseover: function() {
        return false;
      }
    });
});

function avatarchange(){
$("#profileImage").mouseover(function(){
    $("#icon-span").show();
    $("#profileImage").css('opacity','0.5');
    $("#profileImage").css('background', 'rgba(0,0,0,0.5)');
});

$("#icon-span").mouseover(function(){
    $("#icon-span").show();
    $("#profileImage").css('opacity','0.5');
    $("#profileImage").css('background', 'rgba(0,0,0,0.5)');
});

$("#profileImage").mouseout(function(){
    $("#icon-span").hide();
    $("#profileImage").css('opacity','1');
    $("#profileImage").css('background', 'rgba(0,0,0,0)');
});        
}
$(document).ready(function() {
    avatarchange();
});