$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "open") {
            prime_radio.SlideUp()
        }

        if (event.data.type == "close") {
            prime_radio.SlideDown()
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://labrp_radio/escape', JSON.stringify({}));
            prime_radio.SlideDown()
        } else if (data.which == 13) { // Escape key
            $.post('http://labrp_radio/joinRadio', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});

prime_radio = {}

$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('http://labrp_radio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('http://prime_radio/leaveRadio');
});

prime_radio.SlideUp = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 250);
}

prime_radio.SlideDown = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}