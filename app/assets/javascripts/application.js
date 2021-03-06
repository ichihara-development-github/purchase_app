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

    $(".dropdown-toggle").click(function(){
        $(this).next(".dropdown-menu").fadeToggle()
    });

    $("#compare").click(function(){
        $(this).next(".margin-vertical").fadeToggle()
    });
// update basket quatient
    $(".update-input-form").on("change", function(){
      Rails.fire($(this).closest("form")[0], 'submit');
    });

    $(".dropdown-log").on("click", function(){
        $(this).next(".purchacelog").slideToggle()
    });

    $(".fade-menu-toggle").on("click", function(){
        $(this).next(".fade-menu").fadeToggle()
    });

    $('.slide-menu-toggle').on("click", function(){

  if($(this).hasClass('active')) {
    $(this).removeClass('active');
    $(".slide-menu").removeClass('open');

  } else {
    $(this).addClass('active');
    $(".slide-menu").addClass('open');
  }
});

var headersHeight = $('header').outerHeight();
$('.main').css('padding-top', headersHeight + 'px');
$('.slide-menu').css('margin-top', headersHeight + 'px');




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

stripe.confirmCardPayment(clientSecret, {
  payment_method: {
    card: card,
    // billing_details: {
    //   name: 'Jenny Rosen'
    // }
  },
  setup_future_usage: 'off_session'
}).then(function(result) {
  if (result.error) {

    console.log(result.error.message);
  } else {
    if (result.paymentIntent.status === 'succeeded') {

    }
  }
});

stripe.confirmCardPayment(intent.client_secret, {
  payment_method: intent.last_payment_error.payment_method.id
}).then(function(result) {
  if (result.error) {

    console.log(result.error.message);
  } else {
    if (result.paymentIntent.status === 'succeeded') {
    }
  }
});

});
