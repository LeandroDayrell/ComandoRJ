$(document).ready(function() {
    $(document).keyup(function(e) {
        if (e.key === "Escape") {
            $('.homeClothe').hide();
            $('.containerClothe').html('');
            $.post('http://az-homes/close', JSON.stringify({}));
        }
    });
    
    $('#saveClothe').on('click', function() {
        $('.createsClothe').hide();
        $('.saveClothes').fadeIn();
    });
    
    $('#returnHome').on('click', function() {
        $('.createsClothe').fadeIn();
        $('.sectionClothe').hide();
    });

    $('#formClothe').on('click', function() {
        $.post('http://az-homes/save', JSON.stringify({ name: $('.homeClothe').attr('data-home'), set: $('#inputSave').val() }));        
        $('#inputSave').val('');
        $('.createsClothe').fadeIn();
        $('.sectionClothe').hide();
    });

    window.addEventListener('message', function(event) {
        let data = event.data;
        if (data.action == 'open') {
            console.log(data.home);
            $('.homeClothe').fadeIn();
            $('.homeClothe').attr('data-home', data.home);
            GetClothes($('.homeClothe').attr('data-home'));
        }else if (data.action == 'update') {
            GetClothes($('.homeClothe').attr('data-home'));
        }
    });
});

$("#trashClothe").droppable({
    tolerance: "pointer",
    hoverClass: "drop-hover",
    drop: function(event, ui) {
        $.post('http://az-homes/delete', JSON.stringify({ name: $('.homeClothe').attr('data-home'), set: ui.draggable.data("json") }));
    }
});

$("#useClothe").droppable({
    tolerance: "pointer",
    hoverClass: "use-hover",
    drop: function(event, ui) {
        $.post('http://az-homes/wear', JSON.stringify({ name: $('.homeClothe').attr('data-home'), set: ui.draggable.data("json") }));
    }
});

function GetClothes(home) {
    $(".containerClothe").html('');    
    $.post('http://az-homes/get', JSON.stringify({name: home}), (clothes) => {
        $.each(clothes, function(key, clothe) {
            $(".containerClothe").append(`
                <div data-json="${clothe.nomeSet}" class="clotheItem">
                    <div class="iconClothe">
                        <i class="fas fa-cube"></i>
                    </div>
                    <span>${clothe.nomeSet}</span>
                </div>
            `);
        });   
        $('.clotheItem').draggable({
            helper: 'clone',
            opacity: 0.45,
            zIndex: 99999,
            revert: 'invalid',
            start: function(event, ui) {
                selectItem(this);
                $('#usar').removeAttr('disabled');
                $('#dropar').removeAttr('disabled')
                $('#bau').css('background-color', 'rgba(0,0,0,0.10)');
            },
            stop: function() {
                $('#usar').attr('disabled', true);
                $('#dropar').attr('disabled', true)
                $('#bau').css('background-color', 'transparent');
            }
        });             
    });
}

function selectItem(element) {
    $(".clotheItem").css("background-color", "rgba(0, 0, 0, 0.20)");
    $(element).css("background-color", "#9E69D320");
}