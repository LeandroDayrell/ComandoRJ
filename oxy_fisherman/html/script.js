
$(document).ready(function(){

    window.addEventListener("message", function(event){
    
    
        $(".masini").html("<span class='symbol'></span>"+event.data.masini);
        $(".pret").html("<span class='symbol'>Vinde pentru</span>"+event.data.pret);
        $(".numemasina").html("<span class='symbol'>Nume masina </span>"+event.data.numemasina);
        $(".pretoriginal").html("<span class='symbol'>Pret Original  </span> "+event.data.pretoriginal);
        
        
    });
    });
    
    $(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    
    display(false)
    
    window.addEventListener('message', function(event) {
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
            $.post('http://speedo1/exit', JSON.stringify({}));
            return
        }
    };
    
    $("#close").click(function () {
        $.post('http://speedo1/exit', JSON.stringify({}));
        return
    })
    $("#vinde").click(function () {
        $.post('http://speedo1/vinde', JSON.stringify({}));
        return
    })
    $("#rasp1").click(function () {
        if (raspcorect == rasp1){
        $.post('http://speedo1/raspcorectmanule', JSON.stringify({}));
        return
        } else {
            $.post('http://speedo1/raspgresit', JSON.stringify({}));
            return
        }
    })
    $("#rasp2").click(function () {
        if (raspcorect == rasp2){
            $.post('http://speedo1/raspcorectmanule', JSON.stringify({}));
            return
            } else {
                $.post('http://speedo1/raspgresit', JSON.stringify({}));
                return
            }
    })
    $("#rasp3").click(function () {
        if (raspcorect == rasp3){
            $.post('http://speedo1/raspcorectmanule', JSON.stringify({}));
            return
            } else {
                $.post('http://speedo1/raspgresit', JSON.stringify({}));
                return
            }
    })
    $("#rasp4").click(function () {
        if (raspcorect == rasp4){
            $.post('http://speedo1/raspcorectmanule', JSON.stringify({}));
            return
            } else {
                $.post('http://speedo1/raspgresit', JSON.stringify({}));
                return
            }
    })
    
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://speedo1/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://speedo1/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://speedo1/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
    });

    function raspuns() {
        $.post('http://speedo1/exit', JSON.stringify({}));
    }