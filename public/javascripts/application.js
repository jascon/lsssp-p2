// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* On click Or Change Functions */

$(document).ready( function() {
    $('#add_new').click( function() {
        $('#new_form').slideToggle("slow");
    });
    //
    $('#user_role_id').change(function() {
        window.location = "/super_admin/users?id="+$('#user_role_id').val();
    });
    //
    $('#sp_assessors_approved').change(function() {
        window.location = "/service_provider/assessors?approved="+$('#sp_assessors_approved').val()
    });
    //
    $('#sp_students_approved').change(function() {
        window.location = "/service_provider/students?approved="+$('#sp_students_approved').val()
    });
    //
});
