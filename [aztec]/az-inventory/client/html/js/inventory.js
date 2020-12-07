"use strict";

let player = $(`.inventory-player`);
let other = $(`.inventory-other`);

let inventory = {
    ready: (first) => {
        $(`.inventory-player, .inventory-other`).addRemoveItems(8);
        $(`.inventory-player .inventory-row, .inventory-other .inventory-row`).addRemoveItems(5);
        if (first) {
            const spacesReserved = ["img/1.png", "img/2.png", "img/3.png", "img/4.png"];
            for (let i = 0; i < spacesReserved.length; i++) {
                $(".inventory-player > .inventory-row:nth-child(1) > .inventory-cell:nth-child(" + (i + 1) + ")").css({ 'background-image': 'url("' + spacesReserved[i] + '")', 'background-position': 'center', 'background-repeat': 'no-repeat' });
            }
        }
    },
    setup: (type, items) => {
        inventory.clear(type);
        let add = false;
        $.each(items, function (key, value) {
            $(`.inventory-${type} > .inventory-row`).each(function (index, data) {
                $($(data).find(`.inventory-cell`)).each(function (index, data) {
                    if (!$(data).find(`.inventory-item`).attr(`data-item`)) {
                        let amount = `${value.amount} (${(value.weight * value.amount).toFixed(2)})`;
                        if (value.item == `money` || value.item == `dinheirosujo`) {
                            amount = `${formatMoney(value.amount, `R$`)}`; 
                        }
                        let eq = $(`
                            <div class="inventory-item" data-item="${value.item}" data-amount="${value.amount}">
                                <span class="amount-item">${amount}</span>
                                <div class="icon-item" style="width: 112px; height: 108px; background: url('${value.photo}') center center / 65px no-repeat;"></div>
                                <div class="title-item" style="font-size: 10px;width: 110px;height: 23px;">
                                    <span style="position: relative;float: left;top: 50%;left: 50%;transform: translate(-50%, -50%);">${value.label.toUpperCase()}</span>
                                </div>
                            </div>
                        `);
                        $(data).append(eq);
                        eq.data('item', value);
                        eq.data('type', type);
                        eq.mouseenter(function () {
                            $('#item-name').html(value.label);
                            $('#item-description').html(value.description);
                            $('#item-weight').html('Peso: ' + (value.weight * value.amount).toFixed(2));
                            $('#item-amount').html('Quantidade: ' + value.amount);
                        }).mouseleave(function () {
                            $('#item-name').html('');
                            $('#item-description').html('');
                            $('#item-weight').html('');
                            $('#item-amount').html('');
                        });
                        delete items[key];
                        add = false;
                        return false;
                    } else { add = true; }
                });
                if (add == false) return false;
            });
        });
        inventory.sortable();
    },
    clear: (type) => {
        $(`.inventory-${type} > .inventory-row`).each(function (index, data) {
            $($(data).find(`.inventory-cell`)).each(function (index, data) {
                if ($(data).find(`.inventory-item`).attr(`data-item`)) $(data).html(``);
            });
        });
    },
    sortable: () => {
        let sortable = {};
        $(".inventory-cell").sortable({
            scroll: true,
            connectWith: ".inventory-cell",
            placeholder: "inventory-item-sortable-placeholder",
            start: function ( event, ui ) {
                let item = $(this).children().data('item');
                sortable.item = {
                    name: $(this).find('.inventory-item').attr('data-item'),
                    amount: parseInt($('.amountItem').val() ? $('.amountItem').val() : 1),
                    dropable: item.dropable,
                    usable: item.usable
                }
                sortable.source = {
                    type: $(this).closest('.cc').attr('data-type'),
                    entity: $(this).closest('.cc').attr('data-entity')
                };
            },
            receive: function (event, ui) {            
                sortable.target = {
                    type: $(this).closest('.cc').attr('data-type'),
                    entity: $(this).closest('.cc').attr('data-entity')
                }
    
                if (sortable.source.type !== sortable.target.type) {
                    $.post("http://az-inventory/sendItem", JSON.stringify(sortable));
                    $('.amountItem').val('');
                    $('#item-name, #item-description, #item-weight, #item-amount').html('');
                }
                
                $(this).children().not(ui.item).parentToAnimate($(ui.sender), 200);
       
                sortable = {};
            }
        }).each(function () {
            $(this).attr("data-slot-position-x", $(this).prevAll(".inventory-cell").length);
            $(this).attr("data-slot-position-y", $(this).closest(".inventory-row").prevAll(".inventory-row").length);
        }).disableSelection();
    },
    close: () => {
        $('.amountItem').val('');
        $('#item-name, #item-description, #item-weight, #item-amount').html('');
        $('#other-inventory').fadeOut('fast');
        $.post('http://az-inventory/close', JSON.stringify({ type: $('.inventory-other').attr('data-type'), entity: $('.inventory-other').attr('data-entity') }));
        inventory.clear('player');
        inventory.clear('other');
        $('.inventory-player').removeAttr('data-type');
        $('.inventory-player').removeAttr('data-target');
        $('.inventory-player').removeAttr('data-entity');
        $('.inventory-other').removeAttr('data-type');
        $('.inventory-other').removeAttr('data-target');
        $('.inventory-other').removeAttr('data-entity');
    }
}

function formatMoney(n, currency) {
    return currency + n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
}

jQuery.fn.extend({
    addRemoveItems: function (targetCount) {
        return this.each(function () {
            var $children = $(this).children();
            var rowCountDifference = targetCount - $children.length;
            if (rowCountDifference > 0) {
                for (var i = 0; i < rowCountDifference; i++) {
                    $children.last().clone().appendTo(this);
                }
            } else if (rowCountDifference < 0) {
                $children.slice(rowCountDifference).remove();
            }
        });
    },
    parentToAnimate: function (newParent, duration) {
        duration = duration || 'slow';
        var $element = $(this);
        if ($element.length > 0) {
            newParent = $(newParent);
            var oldOffset = $element.offset();
            $(this).appendTo(newParent);
            var newOffset = $element.offset();
            var temp = $element.clone().appendTo('body');
            temp.css({ 'position': 'absolute', 'left': oldOffset.left, 'top': oldOffset.top, 'zIndex': 1000 });
            $element.hide();
            temp.animate({ 'top': newOffset.top, 'left': newOffset.left }, duration, function () {
                $element.show();
                temp.remove();
            });
        }
    }
});

$(document).ready(function () {
    inventory.ready();

    window.addEventListener('message', function (event) {
        var data = event.data;
        if (data.action == 'open') {
            $(".ui").fadeIn();
        } else if (data.action == 'close') {
            $(".ui").fadeOut();
        } else if (data.action == 'update') {
            if (data.type == 'player') {
                inventory.setup('player', data.inventory.items);
                player.attr({'data-type': data.type, 'data-target': data.inventory.user, 'data-entity': data.entity});
                $('#title-player').html(`ply-${data.inventory.user}`);
                $('#weight-player').html(`Weight: ${data.inventory.weight.toFixed(2)} / ${data.inventory.maxweight.toFixed(2)}`);
            } else if (data.type == 'inspect') {
                inventory.setup('other', data.inventory.items);
                other.attr({'data-type': data.type, 'data-target': data.inventory.user, 'data-entity': data.entity});
                $('#title-other').html(`ply-${data.inventory.user}`);
                $('#weight-other').html(`Weight: ${data.inventory.weight.toFixed(2)} / ${data.inventory.maxweight.toFixed(2)}`);
                $('#other-inventory').fadeIn('fast');
            } else if (data.type == 'vehicle') {
                inventory.setup('other', data.inventory.items);
                other.attr({'data-type': data.type, 'data-target': data.inventory.plate, 'data-entity': data.entity});
                $('#title-other').html(`veh-${data.inventory.plate}`);
                $('#weight-other').html(`Weight: ${data.inventory.weight.toFixed(2)} / ${data.inventory.maxweight.toFixed(2)}`);
                $('#other-inventory').fadeIn('fast');
            } else if (data.type == 'home') {
                inventory.setup('other', data.inventory.items);
                other.attr({'data-type': data.type, 'data-target': data.inventory.home, 'data-entity': data.entity});
                $('#title-other').html(`home-${data.inventory.home.toLowerCase()}`);
                $('#weight-other').html(`Weight: ${data.inventory.weight.toFixed(2)} / ${data.inventory.maxweight.toFixed(2)}`);
                $('#other-inventory').fadeIn('fast');
            }
        }
    });

    $(".closeInventory").on("click", function () {
        inventory.close();
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            inventory.close();
        }else if (data.which == 119) {
            inventory.close();
        }
    };

    $('.useItem').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            if (ui.draggable.data("type") == 'player') {
                let item = ui.draggable.data("item");
                let amount = ($('.amountItem').val() ? $('.amountItem').val() : 1);
                if (item.usable && amount > 0) {
                    $.post("http://az-inventory/useItem", JSON.stringify({ item: item.item, amount: parseInt(amount) }));
                    $('.amountItem').val('');
                    $('#item-name, #item-description, #item-weight, #item-amount').html('');
                }
            }
        }
    });

    $('.sendItem').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            if (ui.draggable.data("type") == 'player') {
                let item = ui.draggable.data("item");
                let amount = ($('.amountItem').val() ? $('.amountItem').val() : 1);
                if (amount > 0) {
                    $.post("http://az-inventory/giveItem", JSON.stringify({ item: item.item, amount: parseInt(amount) }));
                    $('.amountItem').val('');
                    $('#item-name, #item-description, #item-weight, #item-amount').html('');
                }
            }
        }
    });

    $('.dropItem').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            if (ui.draggable.data("type") == 'player') {
                let item = ui.draggable.data("item");
                let amount = ($('.amountItem').val() ? $('.amountItem').val() : 1);
                if (item.dropable && amount > 0) {
                    $.post("http://az-inventory/dropItem", JSON.stringify({ item: item.item, amount: parseInt(amount) }));
                    $('.amountItem').val('');
                    $('#item-name, #item-description, #item-weight, #item-amount').html('');
                }
            }
        }
    });  
});