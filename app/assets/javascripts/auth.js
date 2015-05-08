$(document).ready(function(){
    $(document).on('ajax:error', '#user_auth', function(event, jqxhr, settings, exception){
        $('#auth_alert_msg').html(jqxhr.responseText);
    });
    $(document).on('ajax:success', '#user_auth', function(event, jqxhr, settings, exception){
        $('#login_form').modal('toggle');
        $('#login').replaceWith('<a data-method="delete" data-remote="true" href="/users/sign_out" id="logout" rel="nofollow">Logout</a>')
    });
    $(document).on('ajax:success', '#logout', function(event, jqxhr, settings, exception){
        $('#logout').replaceWith('<a data-method="post" data-remote="true" href="login" id="login" rel="nofollow">Login</a>')
    });
});
