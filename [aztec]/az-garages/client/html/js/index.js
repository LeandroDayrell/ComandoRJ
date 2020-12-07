let items = [{all: true}];
let availables = {};
let type = undefined;
let selected = undefined;

let garages = {
    nav: () => {
        items.forEach(i => {
            Object.keys(i).forEach(item => {
                if (i[item]) {
                    i[item] = false;
                }else if (!i[item]) {
                    i[item] = true;
                }
                $(`*[data-category="${item}"]`).toggle();
            });
        });
    },
    tab: (element) => {
        $('.section_content_header > div > .active').removeClass('active');
        $(element).addClass('active');
        $.post('http://az-garages/vehicles', JSON.stringify({select: $(element).attr('data-category'), availables: availables, type: type}), (vehicles) => garages.reload(vehicles)); 
    },
    select: (element, vehicle) => {
        $( ".section_content_item" ).each(function( index, div ) {
            $(div).removeClass('active');
            $(div).css('box-shadow', 'unset');
        });

        if (selected === undefined || selected.plate != vehicle.plate) {
            $(element).addClass('active');
            
            selected = vehicle;

            if (vehicle.state == 0) {
                $('.spawn').removeAttr("disabled");
                $('.spawn').removeClass("desactive");
                $('.despawn, .fare').addClass("desactive");
                $('.despawn, .fare').attr("disabled");
                //$(element).css('border-right', '1px solid #ff9114');
                $(element).css('box-shadow', '0px 0px 5px .5px #ff911460');
            }else if (vehicle.state == 1) {
                $('.despawn').removeClass("desactive");
                $('.despawn').removeAttr("disabled");
                $('.spawn, .fare').addClass("desactive");
                $('.spawn, .fare').attr("disabled");
                //$(element).css('border-right', '1px solid #409eff') ;
                $(element).css('box-shadow', '0px 0px 5px .5px #409eff60');
            }else if (vehicle.state == 2) {
                $('.fare').removeClass("desactive");
                $('.fare').removeAttr("disabled");
                $('.spawn, .despawn').addClass("desactive");
                $('.spawn, .despawn').attr("disabled");
                //$(element).css('border-right', '1px solid #f56c6c');
                $(element).css('box-shadow', '0px 0px 5px .5px #f56c6c60');
            }else if (vehicle.state == 3 || vehicle.state == 4) {
                $('.fare').removeClass("desactive");
                $('.fare').removeAttr("disabled");
                $('.spawn, .despawn').addClass("desactive");
                $('.spawn, .despawn').attr("disabled");
                //$(element).css('border-right', '1px solid #f56c6c');
                $(element).css('box-shadow', '0px 0px 5px .5px #f56c6c60');
            }
        }else{
            $(element).css('box-shadow', 'unset');
            selected = undefined;
        }
    },
    reload: (vehicles) => {
        $('.section_content_itens').empty();
        if (vehicles.length > 0) {
            vehicles.forEach(vehicle => {
                let el = $(`
                <div class="section_content_item">
                    <p>${vehicle.name}</p>
                    <div class="section_content_info">
                        <div>
                            <label>Motor</label><br>
                            <span>${Math.ceil((100 * (vehicle.engine / 1000)))}%</span>
                        </div>
                        <div>
                            <label>Lataria</label><br>
                            <span>${Math.ceil((100 * (vehicle.body / 1000)))}%</span>
                        </div>
                        <div>
                            <label>Gasolina</label><br>
                            <span>${Math.ceil((100 * (vehicle.fuel / 100)))}%</span>
                        </div>
                    </div>
                    <img src="${vehicle.image}">
                </div>`);
                el.click(() => garages.select(el, vehicle));
                $(`.section_content_itens`).append(el);
            });
        }else{
            $(".section_content_itens").html('<br><center><font style="color:rgba(186, 51, 212, 1);">Você não possui nenhum veículo!</font><center>');
        }
        
    },
    spawn: () => {
        if (selected !== undefined) {
            $.post('http://az-garages/spawn', JSON.stringify(selected)); 
            garages.close();
        }
    },
    despawn: () => {
        if (selected !== undefined) {
            $.post('http://az-garages/despawn', JSON.stringify(selected)); 
            garages.close();
        }
    },
    fare: () => {
        if (selected !== undefined) {
            $.post('http://az-garages/fare', JSON.stringify(selected)); 
            garages.close();
        }
    },
    close: () => {
        items = [{all: true}];
        type = undefined;
        availables = {};
        selected = undefined;
        $(`*[data-category]`).hide();
        $(`*[data-category="all"]`).show();
        $.post('http://az-garages/NUIFocusOff', JSON.stringify({}));
    }
}

$(document).ready(function() {
    window.addEventListener('message',function(event){
        let data = event.data;
        
        if (data.action == 'open') {
            $("body").fadeIn('fast');
        }else if (data.action == 'close') {
            $("body").fadeOut('fast');
        }

        if (data.action == 'update') {
            type = data.type;
            availables = data.availables;

            $('.header_title > p').html(data.garage);

            if (data.availables.length > 1) {
                $('.section_content_nav').show();
            }

            $.each(data.availables, function(key, value) {
                if (value == 'car') {
                    if (items.length === 1) {
                        items.push({car: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({car: false});
                    }
                }else if (value == 'motorcycle') {
                    if (items.length === 1) {
                        items.push({motorcycle: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({motorcycle: false});
                    }
                }else if (value == 'truck') {
                    if (items.length === 1) {
                        items.push({truck: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({truck: false});
                    }
                }else if (value == 'helicopter') {
                    if (items.length === 1) {
                        items.push({helicopter: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({helicopter: false});
                    }
                }else if (value == 'bus') {
                    if (items.length === 1) {
                        items.push({bus: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({bus: false});
                    }
                }else if (value == 'boat') {
                    if (items.length === 1) {
                        items.push({boat: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({boat: false});
                    }
                }else if (value == 'jetsky') {
                    if (items.length === 1) {
                        items.push({jetsky: true});
                        $(`*[data-category="${value}"]`).show();
                    }else{
                        items.push({jetsky: false});
                    }
                }
            });

            garages.tab($(`*[data-category="all"]`));
        }
    });

    $(".section_content_search > input").on("keyup", function() {
        let search = $(this).val().toLowerCase();
        $("div.section_content_item > p").filter(function() {
            $(this).closest(".section_content_item").toggle($(this).text().toLowerCase().indexOf(search) > -1)
        });
    });
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        garages.close();
    }
}