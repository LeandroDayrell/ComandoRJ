let months = {[0]: 'Janeiro', [1]: 'Fevereiro', [2]: 'Março', [3]: 'Abril', [4]: 'Maio', [5]: 'Junho', [6]: 'Julho', [7]: 'Agosto', [8]: 'Setembro', [9]: 'Outubro', [10]: 'Novembro', [11]: 'Dezembro'}

$(document).ready(() => {
    let hudp = false;
    let hhealth = false;
    let harmor = false;
    let health = 0;
    let armor = 0;
    window.addEventListener('message', function(e) {
        let data = e.data;

        if (data.action == 'pause') {
            if (data.status) {
                $('body').fadeOut();
            }else if (!data.status) {
                $('body').fadeIn();
            }
        }

        if (data.action == 'basic') {
            if (data.status) {
                hudp = true;
                $('.health > div:nth-child(2) > img, .armor > div:nth-child(2) > img').hide();
                $('.health > div:nth-child(2) > div:nth-child(1), .armor > div:nth-child(2) > div:nth-child(1)').fadeIn('slow');
            }else if (!data.status) {
                hudp = false;
                $('.health > div:nth-child(2) > div:nth-child(1), .armor > div:nth-child(2) > div:nth-child(1)').hide();
                $('.health > div:nth-child(2) > img, .armor > div:nth-child(2) > img').fadeIn('slow');
            }
        }

        if (data.action == 'player') {            
            if (health != parseInt(data.health)) {
                health = data.health;
                $('.health > div:nth-child(1)').css('clip-path', `polygon(50% 0%, ${health}% 50%, 50% 100%, 0% 50%)`);
                $('.health > div:nth-child(2) > div:nth-child(1) > span').html((health < 0) ? '0%' : health + '%');
                if (!hudp && !hhealth) {
                    hhealth = true;
                    $('.health > div:nth-child(2) > .blur').hide();
                    $('.health > div:nth-child(2) > img').hide();
                    $('.health > div:nth-child(2) > div:nth-child(1)').fadeIn('slow');
                    setTimeout(() => {
                        $('.health > div:nth-child(2) > div:nth-child(1)').fadeOut('fast');
                        $('.health > div:nth-child(2) > .blur').fadeIn('fast');
                        setTimeout(() => {
                            $('.health > div:nth-child(2) > img').fadeIn('slow');
                            hhealth = false;
                        }, 300);
                    }, 3500);
                }
            }
            if (armor != parseInt(data.armor)) {
                armor = data.armor;
                $('.armor > div:nth-child(1)').css('clip-path', `polygon(50% 0%, ${armor}% 50%, 50% 100%, 0% 50%)`);
                $('.armor > div:nth-child(2) > div:nth-child(1) > span').html((armor < 0) ? '0%' : armor + '%');
                if (!hudp && !harmor) {
                    harmor = true;
                    $('.armor > div:nth-child(2) > .blur').hide();
                    $('.armor > div:nth-child(2) > img').hide();                        
                    $('.armor > div:nth-child(2) > div:nth-child(1)').fadeIn('slow');
                    setTimeout(() => {
                        $('.armor > div:nth-child(2) > div:nth-child(1)').fadeOut('fast');
                        $('.armor > div:nth-child(2) > .blur').fadeIn('fast');
                        setTimeout(() => {
                            $('.armor > div:nth-child(2) > img').fadeIn('slow');
                            harmor = false;
                        }, 300);
                    }, 3500);
                }
            }
        }

        if (data.action == 'channel') {
            if (data.text) {
                if (data.text == 'OFF') {
                    $('.mode').css('margin-left', 'unset');
                    $('.modal > span').html('Desconectado');
                    $('.modal').fadeOut('fast');
                }else{
                    $('.mode').css('margin-left', '415px');
                    $('.modal > span').html('Frequencia: ' + data.text + ' MHz');
                    $('.modal').fadeIn('fast');
                }
            }else if (!data.text) {
                $('.mode').css('margin-left', 'unset');
                $('.modal').fadeOut('fast');
            }
        }

        if (data.action == 'talking') {
            if (data.status) {
                $('.microphone > img').css('animation', 'blink 1s infinite');
            }else if (!data.status) {
                $('.microphone > img').css('animation', 'unset');
            }
        }

        if (data.action == 'mode') {
            if (data.mode) {
                switch (data.mode) {
                    case 3:
                        $('.mode > span').html('Sussurrando');
                    break;
                    case 8:
                        $('.mode > span').html('Normal');
                    break;
                    case 15:
                        $('.mode > span').html('Gritando');
                    break;
                }
                $('.mode').fadeIn();
                setTimeout(() => {
                    $('.mode').fadeOut();
                }, 3000);
            }
        }

        if (data.action == 'belt') {
            if (data.status) {
                $('.belt').css('animation', 'unset');
            }else if (!data.status) {
                $('.belt').css('animation', 'blink 1s infinite');
            }
        }

        if (data.action == 'street') {
            $('.box-hud > span').html(data.name);
        }

        if (data.action == 'vehicle') {
            if ($(window).width() === 1024) {
                $('.hud-status').css({bottom: '99px', transform: 'translate(-75%, -0%)'});
            }else if ($(window).width() === 1366) {
                $('.hud-status').css({bottom: '99px', transform: 'translate(-118%, -0%)'});
            }else if ($(window).width() === 1440) {
                $('.hud-status').css({bottom: '99px', transform: 'translate(-125%, -0%)'});
            }

            $('.speedometer').show();
            $('.km-speed > small').html(data.date.day + ' de ' + months[data.date.month] + '<i class="far fa-calendar-alt" style="margin-left: 4px;"></i>');
            $('.marcha').html(data.gear);
            $('.vengine').html(Math.ceil((100 * (data.health / 1000))) + '%');
            $('.vfuel').html(Math.ceil((100 * (data.fuel / 100))) + '%');
            $('body > div > div.engine > div').css('width', '100%');
            $('body > div > div.huds > div > div.speedometer > div > div.kmh > label').html(data.speed);
            $('body > div > div.huds > div > div.speedometer > svg > circle.progress.progress-speed').attr('stroke-dasharray', (80 * (data.speed / data.max)) +  ' 150')
        }

        if (data.action == 'vehicleReset') {
            if ($(window).width() === 1024 || $(window).width() === 1366 || $(window).width() === 1440) {
                $('.hud-status').css({bottom: '0', transform: 'unset'});
            }
            $('.speedometer').hide();
        }
    });

    if ($(window).width() === 1024 || $(window).width() === 1366 || $(window).width() === 1440) {
        $('.hud-status').css({bottom: '0', transform: 'unset'});
    }
});