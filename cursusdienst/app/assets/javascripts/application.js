// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide('slow');
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    add_field(link, association, content.replace(regexp, new_id));
}

function add_field(link, association, content) {
    var c = $(content);
    $(link).parent().before(c);
    c.hide();
    c.show('slow');
}

function show_fields(ids) {
    for ( var i=0, len=ids.length; i<len; ++i ){
        $('#'+ids[i]).show('slow');
    }
}

function hide_fields(ids) {
    for ( var i=0, len=ids.length; i<len; ++i ){
        $('#'+ids[i]).hide('slow');
    }
}

function delete_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    var field = $(link).closest(".fields");
    field.hide('slow', function () {field.remove()});
}
