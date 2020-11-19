$(function(){
    $("#back-to-top").hide();

    $(window).scroll(function(){
        if ($(this).scrollTop() > 200){
            $("#back-to-top").fadeIn();
        }else{
            $('#back-to-top').fadeOut();
        }
    });

    $('#back-to-top a').click(function () {

        $('html, body').animate({
            scrollTop: 0
        }, 800);
        return false;

    });
})