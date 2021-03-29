"use strict";

let current     = [];
let selected    = undefined;
let category    = $('.section_content_itens');

let infoVehicle = $('.infocar');
let infoLoading = infoVehicle.find('.loading');

let garage = {
    items: (vehicles) => {
        category.empty();
        if (vehicles.length <= 0 ){
            category.html(`<font class="not-found">Nenhum veículo encontrado.</font>`);
            infoVehicle.hide();
            infoVehicle.css('left', '-433px');
            infoLoading.fadeIn('fast');
            return;
        }
        vehicles.forEach(vehicle => {
            let el = $(`
                <div class="section_content_item" data-model="${vehicle.model}">
                    <p style="font-family: "Bebas Neue";">${vehicle.name}</p>
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
                    <img src="http://131.196.198.113/gtaimg/vehicles/v1/${vehicle.model}.png" onerror="this.onerror=null;this.src='https://i.imgur.com/acV4tCt.png';">
                </div>
            `);
            el.click(ev => {
                let model = el.attr(`data-model`);
                if (model != undefined) {
                    if (selected == undefined || selected.plate == vehicle.plate && selected.model != vehicle.model || selected.plate != vehicle.plate) {
                        $('*[data-model]').css('box-shadow', 'unset');
                        $('*[data-model]').removeClass('active');

                        selected = vehicle;

                        el.addClass('active');
                        if (selected.state == 0) {                            
                            el.css('box-shadow', '0px 0px 5px .5px #ff911460');
                        }else if (selected.state == 1) {
                            el.css('box-shadow', '0px 0px 5px .5px #409eff60');
                        }else if (selected.state == 2) {
                            el.css('box-shadow', '0px 0px 5px .5px #f56c6c60');
                        }else if (selected.state == 3) {
                            el.css('box-shadow', '0px 0px 5px .5px #f56c6c60');
                        }

                        infoVehicle.find(`.vehicle`).hide();
                        infoVehicle.find(`.loading`).fadeIn('fast');
                        garage.view(selected.model);
                    }
                }
            });
            el.data('vehicle', vehicle);
            category.append(el);
        });
    },
    view: (model) => {
        let vehicle = $(`*[data-model="${model}"]`).data("vehicle");
        infoVehicle.fadeIn('fast');
        infoVehicle.find(`.loading`).fadeIn('fast');        
        infoVehicle.css('left', '433px');
        setTimeout(() => {
            infoVehicle.find(`.vehicle > .infocar > b`).html(vehicle.name);
            
            infoVehicle.find(`.vehicle > .infocar > .description > span`).html('');
            infoVehicle.find(`.vehicle > .infocar > .description > span`).hide();
            if (vehicle.description != undefined && vehicle.description != '') {
                infoVehicle.find(`.vehicle > .infocar > .description > span`).show();
                infoVehicle.find(`.vehicle > .infocar > .description > span`).html(vehicle.description);
            }            

            /* tax */
            /*
            if (vehicle.tax <= 0) {
                infoVehicle.find(`.vehicle > .details > .tax > a`).html('Taxa'); 
                infoVehicle.find(`.vehicle > .details > .tax > span`).html(`Paga`);
                infoVehicle.find(`.vehicle > .details > .fare > span`).html(`-`);
            }else if (vehicle.tax > 0) {
                if (vehicle.state === 3){
                    infoVehicle.find(`.vehicle > .details > .tax > a`).html('Detido');
                }else if (vehicle.state === 4){
                    infoVehicle.find(`.vehicle > .details > .tax > a`).html('Roubado');
                }
                infoVehicle.find(`.vehicle > .details > .tax > span`).html(`${garage.time(vehicle.tax)}`);
                infoVehicle.find(`.vehicle > .details > .fare > span`).html(`R$ ${garage.money(vehicle.fare)}`);
            }
            */

            infoVehicle.find(`.vehicle > .details > .tax > a`).html('Taxa'); 
            infoVehicle.find(`.vehicle > .details > .tax > span`).html(`Paga`);
            infoVehicle.find(`.vehicle > .details > .fare > span`).html(`-`);

            if (vehicle.state !== 0 && vehicle.state !== 1 && vehicle.state !== 2){
                if (vehicle.state === 3){
                    infoVehicle.find(`.vehicle > .details > .tax > a`).html('Detido');
                }else if (vehicle.state === 4){
                    infoVehicle.find(`.vehicle > .details > .tax > a`).html('Roubado');
                }
                infoVehicle.find(`.vehicle > .details > .tax > span`).html(`${garage.time(vehicle.tax)}`);
                infoVehicle.find(`.vehicle > .details > .fare > span`).html(`R$ ${garage.money(vehicle.fare)}`);
            }
          
            $('.actions > button').attr('disabled', true);
            if (vehicle.state == 0) {
                $('.actions > button:nth-child(1)').attr('disabled', false);
            }else if (vehicle.state == 1) {
                $('.actions > button:nth-child(2)').attr('disabled', false);
            }else if (vehicle.state == 2 || vehicle.state == 3) {
                $('.actions > button:nth-child(3)').attr('disabled', false);
            }

            /*
            if (vehicle.time > 0 && vehicle.time > parseInt(vehicle.ipva + 24 * 15 * 60 * 60)) {
                infoVehicle.find(`.vehicle > .infocar > .ipva > span`).html('Atrasado');
                $('.actions > button').attr('disabled', true);
                $('.actions > button:nth-child(3)').attr('disabled', false);
            }else{
                infoVehicle.find(`.vehicle > .infocar > .ipva > span`).html('Pago');
            }
            */

            if (vehicle.ipva == 0) {
                $('.actions > button').attr('disabled', true);
                $('.actions > button:nth-child(3)').attr('disabled', false);
                infoVehicle.find(`.vehicle > .details > .tax > a`).html('Taxa'); 
                infoVehicle.find(`.vehicle > .details > .tax > span`).html(`-`);
                infoVehicle.find(`.vehicle > .details > .ipva > span`).html(`Atrasado`);
            }else{
                infoVehicle.find(`.vehicle > .infocar > .ipva > span`).html('Pago');
            }

            infoVehicle.find(`.vehicle > .imgcar > img`).attr('src', `http://131.196.198.113/gtaimg/vehicles/v2/${vehicle.model}.png`);

            infoVehicle.find(`.loading`).hide();
            infoVehicle.find(`.vehicle`).fadeIn('fast');

        }, (Math.floor(Math.random() * 1000) + 500));
    },
    time: (timestamp) => {
        let a = new Date(timestamp * 1000);
        let months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
        let year = a.getFullYear();
        let month = months[a.getMonth()];
        let date = a.getDate();
        if (date < 10) date = "0" + date;
        let hour = a.getHours();
        if (hour < 10) hour = "0" + hour; 
        let min = a.getMinutes();
        if (min < 10) min = "0" + min;
        let sec = a.getSeconds();
        if (sec < 10) sec = "0" + sec;
        return date + '/' + month + '/' + year + ' ' + hour + ':' + min + ':' + sec;
    },
    money: (value) => {
        if (typeof value != 'number') return 0;
        return value.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
    },
    spawn: () => {
        infoVehicle.find('.actions > button:nth-child(1)').attr('disabled', true);
        if (selected != undefined) {
            garage.client('spawn', {model: selected.model, plate: selected.plate, garage: current}, (result) => {
                if (result) {
                    infoVehicle.find('.actions > button:nth-child(1)').attr('disabled', false);
                    garage.close();
                }
            });
        }
    },
    despawn: () => {
        infoVehicle.find('.actions > button:nth-child(2)').attr('disabled', true);
        if (selected != undefined) {
            garage.client('despawn', {model: selected.model, plate: selected.plate, garage: current}, (result) => {
                if (result) {
                    infoVehicle.find('.actions > button:nth-child(2)').attr('disabled', false);
                    garage.close();
                }
            });
        }
    },
    fare: () => {
        infoVehicle.find('.actions > button:nth-child(3)').attr('disabled', true);
        if (selected != undefined) {
            garage.client('fare', {model: selected.model, plate: selected.plate, garage: current}, (result) => {
                if (result) {
                    infoVehicle.find('.actions > button:nth-child(3)').attr('disabled', false);
                    garage.close();
                }
            });
        }
    },
    client: (event, data, cb) => {
        $.post(`http://az-garages/${event}`, JSON.stringify((data === undefined) ? {} : data), (cb === undefined) ? () => {} : cb);
    },
    close: () => {
        garage.client('close');
        selected = undefined;
    }
}

window.addEventListener("message", function (event) {
    let data = event.data;
    switch (data.action) {
        case 'open':
            $('body').fadeIn('fast');
            garage.items(data.vehicles);
            current = JSON.parse(data.garage);
        break;
        case 'update':
            garage.items(data.vehicles);
        break;
        case 'close':
            $('body').fadeOut('fast');     
            infoVehicle.css('left', '-433px');  
            infoVehicle.find('.vehicle').hide();    
            $('.actions > button').attr('disabled', true); 
        break;
    }
});

document.onkeyup = function (data) {
    if (data.which == 27) garage.close();
};

$(".section_content_search > input").on("keyup", function() {
    let search = $(this).val().toLowerCase();
    $("div.section_content_item > p").filter(function() {
        $(this).closest(".section_content_item").toggle($(this).text().toLowerCase().indexOf(search) > -1)
    });
});