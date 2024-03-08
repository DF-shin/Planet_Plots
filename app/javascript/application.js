// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require select2
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import $ from "jquery"
import "select2"
import Swal from "sweetalert2"
window.Swal = Swal

// document.addEventListener("turbo:load", function() {
//   $('.select2-enable').select2({
//     width: '100%', // Adjust as needed
//     placeholder: "Type or select a planet",
//     allowClear: true,
//     minimumInputLength: 1, // Minimum number of characters to start the search
//     ajax: {
//       url: '/plots/search_planets', // Update this to your new endpoint
//       dataType: 'json',
//       delay: 250, // Wait 250ms before triggering the request
//       data: function (params) {
//         return {
//           term: params.term // search term
//         };
//       },
//       processResults: function (data) {
//         return {
//           results: data
//         };
//       },
//       cache: true
//     },
//     tags: true // Allow the user to freely enter text
//   });
// });
// document.addEventListener("turbolinks:load", function() {
//   $('.select2-enable').select2({
//     width: '100%',
//     placeholder: "Type or select a planet",
//     allowClear: true,
//     tags: true // This is crucial for allowing new entries
//   });
// });

// document.addEventListener("turbolinks:load", function() {
//   console.log("jQuery version: ", $.fn.jquery); // Log jQuery version
//   console.log("Initializing Select2");
//   $('#planet_name').select2({
//     width: '100%',
//     placeholder: "Type or select a planet",
//     allowClear: true,
//     ajax: {
//       url: '/plots/search_planets', // Ensure this endpoint is correct
//       dataType: 'json',
//       delay: 250, // Wait 250ms after typing stops to send the request
//       data: function(params) {
//         // Match this parameter name with your backend expectation
//         return { term: params.term };
//       },
//       processResults: function(data) {
//         // Transforms the top-level key of the response array from 'items' to 'results'
//         return { results: data };
//       }
//     },
//     minimumInputLength: 1, // User must type at least 1 character
//   });
// });

document.addEventListener("turbolinks:load", function() {
  $('#planet_select').select2({
    placeholder: "Select or type to create a new planet",
    tags: true, // Allows the creation of new entries
    createTag: function (params) {
      // This method is called when a tag is being created and allows you to control how it is created.
      // Here, you could potentially send an AJAX request to pre-validate the tag name or modify it.
      return {
        id: params.term,
        text: params.term,
        newOption: true
      };
    }
  }).on('select2:select', function (e) {
    var data = e.params.data;
    if (data.newOption) {
      // If the selected option is a new tag, handle it accordingly.
      // You might want to dynamically update another part of your form or send an AJAX request here.
      console.log('New planet name:', data.text);
      // Example: update a hidden field with the new planet name.
      $('#new_planet_name').val(data.text);
    }
  });
});
