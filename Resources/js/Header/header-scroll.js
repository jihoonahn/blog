$(document).ready(function(){
    $(window).on('scroll', function(){
        if ($(window).scrollTop()) {
            $(".site-header").addClass('site-header-bottom-border');
            $(".site-header").addClass('site-header-bottom-bg-border');
            $(".site-header").removeClass('site-header-dark');
        }else{
            $(".site-header").removeClass('site-header-bottom-border');
            $(".site-header").removeClass('site-header-bottom-bg-border');
            $(".site-header").addClass('site-header-dark');
        }
    });
});
