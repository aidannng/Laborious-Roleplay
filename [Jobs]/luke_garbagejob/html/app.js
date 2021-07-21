let percent;
$('#locker-menu').hide();
$('#vehicles').hide();
$('#collections').hide();

// If ESC is pressed, hide NUI
document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post('https://luke_garbagejob/luke_garbagejob:CloseMenu');
        $('#locker-menu').hide();
        $('#vehicles').hide();
        return
    }
};

window.addEventListener('message', function(event) {
    if (event.data.type == 'changeJob') {
        $('#locker-menu').hide();
        $('#vehicles').hide();
        $('#collections').hide();
    }

    if (event.data.type == 'locker') {
        $('#locker-menu').show();
    }

    if (event.data.type == 'vehicle') {
        $('#vehicles').show();
    }

    if (event.data.type == 'setDefault') {
        $('#collections').show()
        $('.max-progress').html(`${event.data.maxLevelTwo}`);
    }

    if (event.data.type == 'updateCollected') {
        $('.amount').html(`Total collected: ${event.data.value}`);
        $('.level-progress').html(event.data.value2);
        percent = (event.data.value2 / event.data.maxValue) * 100;
        $('.progress-bar').width(percent + "%");
    }

    if (event.data.type == 'updateLevel') {
        $('.level').html(`Level: ${event.data.level}`);
        if (event.data.level == 2) {
            $('.max-progress').html(event.data.max);
        } else if (event.data.level == 3){
            $('.max-progress').html('Max');
            $('.progress-bar').css({'width': '100%', 'transition': '0.5s'})
        }
    }
});

$('.sign-in').click(function() {
    $.post('https://luke_garbagejob/luke_garbagejob:SetOnDuty');
    $.post('https://luke_garbagejob/luke_garbagejob:CloseMenu');
    $('#locker-menu').hide();
});

$('.sign-out').click(function() {
    $.post('https://luke_garbagejob/luke_garbagejob:SetOffDuty');
    $.post('https://luke_garbagejob/luke_garbagejob:CloseMenu');
    $('#locker-menu').hide();
    $('#collections').hide();
});


$('.vehicle1').click(function() {
    $.post('https://luke_garbagejob/luke_garbagejob:SpawnJobVehicle', JSON.stringify('vehicle1'));
    $.post('https://luke_garbagejob/luke_garbagejob:CloseMenu');
    $('#vehicles').hide();
});

$('.vehicle2').click(function() {
    $.post('https://luke_garbagejob/luke_garbagejob:SpawnJobVehicle', JSON.stringify('vehicle2'));
    $.post('https://luke_garbagejob/luke_garbagejob:CloseMenu');
    $('#vehicles').hide();
});