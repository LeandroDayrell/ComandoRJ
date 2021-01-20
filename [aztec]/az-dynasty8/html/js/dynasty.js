let salesman = 0;
let permission = false;

var arr = ['home', 'sale', 'details'];
var i = 0;

function nextItem() {
    i = i + 1;
    i = i % arr.length;
    return arr[i];
}

function prevItem() {
    if (i === 0) {
        i = arr.length;
    }
    i = i - 1;
    return arr[i];
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details').fadeOut();
        i = 0;
        $.post('http://az-dynasty8/NUIFocusOff', JSON.stringify({}));
        resetInput();
    }
});

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        let data = event.data;
        if (data.action == 'open') {
            salesman = data.salesman;
            permission = data.permission;
            $('.borderTablet').fadeIn();
            $('.titulo').html('<p>A melhor mudança da sua vida</p>');
            $('#url-link').html('www.dynasty8realestate.com');
            progressUp(null, '.site-dynasty, .home');
        }else if (data.action == 'close') {
            permission = false;
            $('.borderTablet').fadeOut();
        }
    });
});

$(() => {
    $('.url-acao > .home').on('click', function() {
        if (i != 0) {
            i = 0;
            $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
            $('.edit, .editCancelButton, .editButton').hide();
            $('#url-link').html('www.dynasty8realestate.com/inicio');
            $('.titulo').html('<p>A melhor mudança da sua vida</p>');
            $('.titulo').css('padding', '0px');
            progressUp(null, '.content-dynasty > .home');
        }
    });

    $('.url-acao > .back').on('click', function() {        
        if (i != 0) {
            $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
            $('.edit, .editCancelButton, .editButton').hide();
            let prev = prevItem();
            if (prev == 'sale') {
                $('#url-link').html('www.dynasty8realestate.com/a-venda');
                $.post('http://az-dynasty8/GetHomesTypes', JSON.stringify({}), (types) => {
                    $('.titulo').html('');
                    $('.titulo').css('padding', '6px');
                    $.each(types, function(key, type) {
                        if (type == 'casa') {
                            $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">SIMPLES</button>`);
                        }else if (type == 'streamer') {
                            //$('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">NOBRES</button>`);
                        }else if (type == 'casasvip') {
                            //$('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">MANSÕES</button>`);
                        }else if (type == 'casasShevi') {
                            $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">MOSQUITO</button>`);
                        }else{
                            $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">${type}</button>`);
                        }
                    });
                });
                setTimeout(function(){
                    $('.wrapHome').html('');
                    $.post('http://az-dynasty8/GetHomesList', JSON.stringify({}), (homes) => {
                        $('#CasasTotal').html('0');
                        $.each(homes, function(key, home) {   
                            setTimeout(function(){
                                $('.wrapHome').append(`
                                <div class="boxSell" data-category="${home.categoria}" style="display:none;">
                                    <div class="homeSell">
                                        <div class="item-casa" onclick="changeHome(this)" data-photo="${home.img}" data-id="${home.id}" data-price="${home.preco}" data-name="${home.nome}" data-chest="${home.chest}" data-coords="${JSON.stringify(home.entry)}">
                                            <div class="item-imagem" style="background-image: url(${home.img});">
                                                <div class="item-titulo"><span style="text-transform: uppercase">${home.nome}</span></div>
                                            </div>
                                            <p>${home.categoria}</p>
                                            <div class="item-compra">
                                                <span>${formatMoney(home.preco, 'R$')}</span>                                
                                            </div>
                                            <p>${home.street}</p>
                                        </div>
                                    </div>
                                </div>`);
                            }, 50);
                        });
                        setTimeout(function(){
                            $('#CasasTotal').html($('.wrapHome').find(`.boxSell[data-category="casa"]`).length);
                            $(`.boxSell[data-category="casa"]`).fadeIn('slow');
                        }, 100);
                    });
                }, 700);
                $(".searchHome").keyup(function() {
                    let = search = $(this).val().toLowerCase();            
                    $('.boxSell').removeClass('filter');
                    $('.boxSell').each(function(index, dataSell){                
                        $($(dataSell).find(".homeSell > .item-casa")).each(function(index, dataHome){
                            let item = $(dataHome).find(".item-imagem > .item-titulo > span").text().toLowerCase();                    
                            if (item.match(search) == null) {
                                $(dataSell).addClass('filter');
                            }
                        })
                    });
                });
            }else{
                if (prev == 'home') {
                    $('.titulo').html('<p>A melhor mudança da sua vida</p>');
                    $('.titulo').css('padding', '0px');
                    $('#url-link').html('www.dynasty8realestate.com/inicio');
                }else{
                    $('#url-link').html('www.dynasty8realestate.com/' + prev);
                }                
            }
            progressUp(null, '.content-dynasty > .' + prev);
        }
    });   

    $('.url-acao > .add').on('click', function() {
        $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
        $('.edit, .editCancelButton, .editButton').hide();
        $('.titulo').html('<p>A melhor mudança da sua vida</p>');
        $('.titulo').css('padding', '0px');
        progressUp(null, '.content-dynasty > .add');
    });

    $('.block').on('click', function() {
        $('.block').removeClass('active');
        $(this).addClass("active");
    });

    $('.url-acao > .close').on('click', function() {
        $.post('http://az-dynasty8/NUIFocusOff', JSON.stringify({}));
        $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
        $('.edit, .editCancelButton, .editButton').hide();
        resetInput();
    });

    $('.visitButton').on('click', function() {
        $.post('http://az-dynasty8/VisitHome', JSON.stringify({id: $('.visitButton').attr('data-id'), name: $('.visitButton').attr('data-name'), user_id: $('.visitID').val(), time: $('.visitTime').val(), salesman: salesman}));
        $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
        $('.edit, .editCancelButton, .editButton').hide();
        i = 0;
        $.post('http://az-dynasty8/NUIFocusOff', JSON.stringify({}));
        resetInput();
    });

    $('.buyButton').on('click', function() {
        $.post('http://az-dynasty8/BuyHome', JSON.stringify({id: $('.visitButton').attr('data-id'), name: $('.visitButton').attr('data-name'), user_id: $('.visitID').val(), time: $('.visitTime').val(), salesman: salesman}));
        $('.content-dynasty > .home, .content-dynasty > .sale, .content-dynasty > .details, .content-dynasty > .add').hide();
        $('.edit, .editCancelButton, .editButton').hide();
        i = 0;
        $.post('http://az-dynasty8/NUIFocusOff', JSON.stringify({}));
        resetInput();
    });

    $('.gpsButton').on('click', function() {
        $.post('http://az-dynasty8/GPSHome', JSON.stringify({id: $('.visitButton').attr('data-id'), name: $('.visitButton').attr('data-name'), salesman: salesman}));
    });   

    $('.editButton').on('click', function() {
        $('.options, .editButton').hide();
        $('.edit, .editCancelButton').show();        
    });
    
    $('.editCancelButton').on('click', function() {
        $('.edit, .editCancelButton').hide();
        $('.options, .editButton').show();
    });

    $('.editSaveButton').on('click', function() {
        $.post('http://az-dynasty8/PriceHome', JSON.stringify({name: $('.visitButton').attr('data-name'), price: $('.homePrice').val()}), (bool) => {
            if (bool) {
                $('.price').html(formatMoney(parseInt($('.homePrice').val()), 'R$'));
                if (permission) {
                    $('.warnInfo > p').html('Comissão: ' + formatMoney(parseInt($('.homePrice').val()*(20/100)), 'R$'));
                    $('.edit, .editCancelButton').hide();
                    $('.options, .editButton').show();
                }
            }
        });
    });

    $('.homes').on('click', function() {
        $('.wrapHome').html('');
        nextItem();
        $('#url-link').html('www.dynasty8realestate.com/casas');
        progressUp('.content-dynasty > .home', '.content-dynasty > .sale');
        $.post('http://az-dynasty8/GetHomesTypes', JSON.stringify({}), (types) => {
            $('.titulo').html('');
            $('.titulo').css('padding', '6px');
            $.each(types, function(key, type) {
                if (type == 'casa') {
                    $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">SIMPLES</button>`);
                }else if (type == 'streamer') {
                    //$('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">NOBRES</button>`);
                }else if (type == 'casasvip') {
                    //$('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">MANSÕES</button>`);
                }else if (type == 'casasShevi') {
                    $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">MOSQUITO</button>`);
                }else{
                    $('.titulo').append(`<button class="menu-button" data-category="${type}" onclick="selectItem(this)">${type}</button>`);
                }
            });
        });
        setTimeout(function(){
            $.post('http://az-dynasty8/GetHomesList', JSON.stringify({}), (homes) => {
                $('#CasasTotal').html('0');
                $.each(homes, function(key, home) {   
                    setTimeout(function(){
                        $('.wrapHome').append(`
                        <div class="boxSell" data-category="${home.categoria}" style="display:none;">
                            <div class="homeSell">
                                <div class="item-casa" onclick="changeHome(this)" data-photo="${home.img}" data-id="${home.id}" data-price="${home.preco}" data-name="${home.nome}" data-chest="${home.chest}" data-coords="${JSON.stringify(home.entry)}">
                                    <div class="item-imagem" style="background-image: url(${home.img});">
                                        <div class="item-titulo"><span style="text-transform: uppercase">${home.nome}</span></div>
                                    </div>
                                    <p>${home.categoria}</p>
                                    <div class="item-compra">
                                        <span>${formatMoney(home.preco, 'R$')}</span>                                
                                    </div>
                                    <p>${home.street}</p>
                                </div>
                            </div>
                        </div>`);
                    }, 50);
                });
                setTimeout(function(){
                    $('#CasasTotal').html($('.wrapHome').find(`.boxSell[data-category="casa"]`).length);
                    $(`.boxSell[data-category="casa"]`).fadeIn('slow');
                }, 100);
            });
        }, 700);
        $(".searchHome").keyup(function() {
            let = search = $(this).val().toLowerCase();            
            $('.boxSell').removeClass('filter');
            $('.boxSell').each(function(index, dataSell){                
                $($(dataSell).find(".homeSell > .item-casa")).each(function(index, dataHome){
                    let item = $(dataHome).find(".item-imagem > .item-titulo > span").text().toLowerCase();                    
                    if (item.match(search) == null) {
                        $(dataSell).addClass('filter');
                    }
                })
            });
        });
    });
});

function changeHome(element) {
    if (permission) {
        $('.options, .editButton').show();
        $('.warnInfo > p').html('Comissão: ' + formatMoney(parseInt($(element).attr('data-price')*(20/100)), 'R$'));
    }else if (!permission) {
        $('.options, .editButton').hide();
        $('.warnInfo > p').html('Informe ao agente imobiliario o nome da residencia!');
    }
    nextItem();
    $('#url-link').html('www.dynasty8realestate.com/detalhes/' + $(element).attr('data-id'));
    progressUp('.content-dynasty > .sale', '.content-dynasty > .details');
    $('.name').html($(element).attr('data-name'));
    $('.kg').html($(element).attr('data-chest'));
    $('.price').html(formatMoney(parseInt($(element).attr('data-price')), 'R$'));
    $('.imgInfos').css('background-image', 'url(' + $(element).attr('data-photo') + ')');
    $('.visitButton').attr('data-id', $(element).attr('data-id'));
    $('.visitButton').attr('data-name', $(element).attr('data-name'));
    $('.buyButton').attr('data-id', $(element).attr('data-id'));    
    $('.buyButton').attr('data-name', $(element).attr('data-name'));
    $('.titulo').html('<p>A melhor mudança da sua vida</p>');
    $('.titulo').css('padding', '0px');
}

function formatMoney(n, currency) {
    return currency + n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
}

function progressUp(hide, show) {
    $('.site-dynasty').hide();
    $('.site-progress').css('width', '0px');
    $('.site-progress').fadeIn('fast');
    $('.site-progress').css('width', (832 * (100 / 100)) + "px");
    setTimeout(function(){
        $('.site-dynasty').show();
        $('.site-progress').fadeOut();
        if (hide != null) {
            $(hide).hide();
        }
        if (show != null) {
            $(show).fadeIn('fast');
        }
    }, 1000);
}

function resetInput() {
    $('.titulo, .wrapHome, #CasasTotal').html('');
    $('.searchHome, .visitTime, .visitID, .homePrice').val('');
}