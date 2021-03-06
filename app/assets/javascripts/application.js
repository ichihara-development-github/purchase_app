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
//= require jquery
//= require jquery.turbolinks
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require "raty"

$(function(){

// update basket quatient
    $(".update-input-form").on("change", function(){
      Rails.fire($(this).closest("form")[0], 'submit');
    });


    $(".dropdown-toggle").click(function(){
        $(this).next(".dropdown-menu").fadeToggle()
    });

    $("#compare").click(function(){
        $(this).next(".margin-vertical").fadeToggle()
    });

    $(".dropdown-log").on("click", function(){
        $(this).next(".purchaselog").slideToggle()
    });

    $(".fade-menu-toggle").on("click", function(){
        $(this).next(".fade-menu").fadeToggle()
    });

    $('.slide-menu-toggle').on("click", function(){
     $(".slide-menu").toggleClass("open");
  });

  var pagetop = $('#to_top');

  $(window).scroll(function () {
      if ($(this).scrollTop() > 300) {  //100pxスクロールしたら表示
          pagetop.fadeIn();
      } else {
          pagetop.fadeOut();
      }
  });
  pagetop.click(function () {
      $('body,html').animate({
          scrollTop: 0
      }, 450); //0.5秒かけてトップへ移動
      return false;
  });



var style = {
    base: {
        color: "#32325d",
    }
};

var card = elements.create("card", {style: style});
card.mount("card-element");

card.addEventListener("change", function(event) {
    card.displayError = document.GetElementById("card-errors");
    if (event.error){
        displayError.textContent =event.error.message;
    }else {
        displayError.textContent
    }
});

});
