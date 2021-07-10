$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

 
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://respray-nui/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://respray-nui/exit', JSON.stringify({}));
        return
    })

    function resetUI()
    {
        $('.accordion-button').each(function(){
            $(this).addClass('collapsed').attr('area-expanded', false)
        });
		
		$('.accordion-collapse').each(function(){
            $(this).addClass('collapse').removeClass('show')
        });
    }

    var colors = "";
    $('.color').each(function () {
        var id = this.id;
        var color = "#" + $(this).data("color");
        var colorID = $(this).data("color-id");
        
        $('#' + id).css("background-color", color).css("font-size", ".5em")//.html(colorID);
		var css = $('#' + id).css("background-color");
		rgb = css.substring(4,css.length-1);
        $('#' + id).attr("data-rgb", rgb);
    });

    $('.primary').click(function(){
        var id = this.id;
        var typeID = -1
        if(id.indexOf("metallic") >= 0)
        {
            typeID = 1
        }
        else if(id.indexOf("matte") >= 0)
        {
            typeID = 3
        }

        var color = $(this).data("color");
        var colorID = $(this).data("color-id");
        var rbg = $(this).data("rgb");

        $.post('http://respray-nui/primary', JSON.stringify({
            color: colorID,
            type: typeID
        }));
    })

    $('.secondary').click(function(){
        var id = this.id;
        var typeID = -1
        if(id.indexOf("metallic") >= 0)
        {
            typeID = 1
        }
        else if(id.indexOf("matte") >= 0)
        {
            typeID = 3
        }

        var color = $(this).data("color");
        var colorID = $(this).data("color-id");
        var rbg = $(this).data("rgb");

        $.post('http://respray-nui/secondary', JSON.stringify({
            color: colorID,
            type: typeID
        }));
    })

    $('.pearl').click(function(){
        var id = this.id;
        var typeID = 1

        var color = $(this).data("color");
        var colorID = $(this).data("color-id");
        var rbg = $(this).data("rgb");

        $.post('http://respray-nui/pearl', JSON.stringify({
            color: colorID,
            type: typeID
        }));
    })

    $('.interior').click(function(){
        var id = this.id;
        var typeID = 2

        var color = $(this).data("color");
        var colorID = $(this).data("color-id");
        var rbg = $(this).data("rgb");

        $.post('http://respray-nui/interior', JSON.stringify({
            color: colorID,
            type: typeID
        }));
    })

    $('.wheel').click(function(){
        var id = this.id;
        var typeID = 1

        var color = $(this).data("color");
        var colorID = $(this).data("color-id");
        var rbg = $(this).data("rgb");

        $.post('http://respray-nui/wheel', JSON.stringify({
            color: colorID,
            type: typeID
        }));
    })
})