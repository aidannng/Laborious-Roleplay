$(function () {
    display(false)
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
            times = [];
            best = 0;
        }
    }

    function convertTime(time)
    {
        if(time == 0)
        {
            return "00.00";
        }

        if(time.toString().length == 4)
        {
            time = "0" + time
        }
        else
        {
            if(time >= 60.00)
            {
                var minutes = Math.floor(time/60.00);

                if(minutes.toString().length == 1)
                {
                    minutes = "0" + minutes
                }
                var seconds = (time - (minutes*60)).toFixed(2);
                if(seconds.toString().length == 4)
                {
                    seconds = "0" + seconds
                }
                time = minutes + ":" + seconds;
            }
        }
        return time;
    }

    var times = [];
    var best = 0;
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

        if(item.updatetime)
        {
            var time = (item.time/1000).toFixed(2);

            $('#time').empty().html(convertTime(time));
        }

        if(item.updatelaps)
        {
            var time = (item.time/1000).toFixed(2);
            var difference = 0
            var totaltime = 0;
            if(times.length > 0)
            {
                for(var x=1; x<times.length; x++)
                {
                    totaltime = (parseFloat(totaltime) + parseFloat(times[x])).toFixed(2);
                }
                difference = (time - totaltime).toFixed(2);
                times.push(difference);

                if(times.length == 2)
                {
                    best = difference
                }
            }
            else
            {
                times.push(time);
            }

            for(var x=0; x<times.length; x++)
            {
                if(times[x] != 0)
                {
                    if(parseFloat(times[x]) < parseFloat(best))
                    {
                        best = times[x];
                    }
                }
            }

            $("#best").empty().html(convertTime(best));

            $('#last').empty().html(convertTime(difference));

            $('#laps').empty().html(item.lap + " / " + item.laps);
        }

        if(item.gettime)
        {
            var time = (item.time/1000).toFixed(2);

            time = convertTime(time);

            var minutes = 0;
            var seconds = 0;
            var milliseconds = 0;
            if(time.length == 8)
            {
                minutes = time[time.length-8] + time[time.length-7]
                if(minutes[0] == "0")
                {
                    minutes = minutes[1];
                }
            }
            seconds = time[time.length-5] + time[time.length-4];
            if(seconds[0] == "0")
            {
                seconds = seconds[1];
            }
            milliseconds = time[time.length-2] + time[time.length-1];
            if(milliseconds[0] == "0")
            {
                milliseconds = milliseconds[1];
            }

            $.post('http://timer-nui/createtrialtime', JSON.stringify({
                track:item.track,
                model:item.model.toLowerCase(),
                minutes:minutes,
                seconds:seconds,
                milliseconds:milliseconds,
            }))
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://timer-nui/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://timer-nui/exit', JSON.stringify({}));
        return
    })

    function resetUI()
    {
        
    }
})