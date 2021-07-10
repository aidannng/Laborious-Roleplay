window.addEventListener('message', function(event) {
    if (event.data.action == "show") {
        $("#drawtext-shell").css("background-color", event.data.color);
        $('#drawtext-shell').text(event.data.text);
        $('#drawtext-shell').fadeIn('fast');
    } else if (event.data.action == "hide") {
        $('#drawtext-shell').fadeOut('fast');
    }
});