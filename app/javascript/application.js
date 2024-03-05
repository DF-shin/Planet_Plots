// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require select2
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import $ from "jquery"
import "select2"

document.addEventListener("DOMContentLoaded", () => {
  $(document).ready(function() {
    $('.select2-enable').select2({
      width: '100%', // Adjust based on your needs
      placeholder: "Type or select a planet",
      allowClear: true
    });
  });
});
