// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery/dist/jquery.min
//= require jquery_ujs
//= require bootstrap/dist/js/bootstrap.min
//= require jquery_nested_form
//= require Flot/jquery.flot.js
//= require Flot/jquery.flot.time
//= require_tree .

$(function(){
  if (gon.stocks_data != undefined) {
    var dataset = [];
    $.each(gon.stocks_data, function(index, object){
      var obj = {};
      $.each(object, function(key, element) {
        obj.label = key;
        obj.data = element;
      });
      dataset.push(obj)
    });
    $.plot($("#flot"), dataset, {
      'series': {
        'lines': {
          'show': true
        }
      },
      'legend': {
        'show': true
      },
      'xaxis': {
        mode: "time"
      }
    });
  }
});
