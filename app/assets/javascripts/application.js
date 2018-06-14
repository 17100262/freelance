// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets REA$( document ).on('turbolinks:load', function() {DME (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require toastr
//= require_tree .
//= require social-share-button

  $(document).ready(function() {
    $('.alert-info').delay(3000).fadeOut();
  });
  
  $(document).ready(function(){
      
      $('.search-btn').click(function(){
         $('.job-search').css('display','block');
      });
      
      
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
  jQuery(function($) {
    if ($(window).width() > 769) {
      $('.nav .dropdown').hover(function() {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
  
      }, function() {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp();
  
      });
      $('.nav .dropdown > a').click(function() {
        location.href = this.href;
      });
  
    }
  });
  });