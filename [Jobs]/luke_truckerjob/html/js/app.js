$('#container').hide();

var maxProgress = 0;
var maxLevel = 0;
var percent = 0;
var progress = 0;
var level = 0;

window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.type == 'visibility') {
        if (item.setVisibility == true) {
            maxProgress = item.maxProgress;
            maxLevel = item.maxLevel;

            $('.level-text').text(`Level: ${item.level} / ${item.maxLevel}`);
            $('.progress-text').text(`${item.progress} / ${item.maxProgress}`);
            percent = (item.progress / item.maxProgress) * 100;
            $('.progress-bar').width(`${percent}%`);
            $('#container').fadeIn(400, 'swing', function() {
                setTimeout(function() {
                    $('#container').fadeOut();
                }, 5000)
            });
        } else {
            $('#container').fadeOut();
        }
    }

    if (item.type == 'update') {
        progress = item.progress;
        level = item.level;
        maxProgress = item.maxProgress

        percent = (progress / maxProgress) * 100;
        
        $('#container').fadeIn(400, 'swing', function() {
            setTimeout(function() {
                $('.level-text').text(`Level: ${level} / ${maxLevel}`);
                $('.progress-text').text(`${progress} / ${maxProgress}`);
                $('.progress-bar').width(`${percent}%`);
                setTimeout(function() {
                    $('#container').fadeOut();
                }, 5000)
            }, 500)
        })
    }
})