$(document).ready(function() {
    $(window).on('scroll', function() {
        if ($(window).scrollTop()) {
            $("#blog-head").addClass('header-bc');
        }else{
            $("#blog-head").removeClass('header-bc');
        }
    });
});
