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

function add_fields(link, association, new_id, content) {
//    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    add_field(link, association, content.replace(regexp, new Date().getTime()));
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
    field.hide('slow', function () {
        field.remove()
    });
}

function filter_select_on_change(parent_id, child_id, data_key) {
    var id_value_string = $("select#"+parent_id).val();
    if (id_value_string == "") {
        // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
        $("select#"+child_id + " option").remove();
        $(row).appendTo("select#"+child_id);
        $("select#"+child_id)[0].onchange();
    }
    else {
        // Send the request and update sub category dropdown
        $.ajax({
            dataType: "json",
            cache: false,
            url: '/filters/get_children_from_parent?',
            data: data_key+"=" + id_value_string,
            timeout: 2000,
            error: function(XMLHttpRequest, errorTextStatus, error){
								$('#ajax_errors').append("Failed to submit : "+ errorTextStatus+" ;"+error)
            },
            success: function(data){
                // Clear all options from sub category select
                $("select#"+child_id + " option").remove();
                //put in a empty default line
                var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                $(row).appendTo("select#"+child_id);
                // Fill sub category select
                $.each(data, function(i, j){
                    row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
                    $(row).appendTo("select#"+child_id);
                });
                $("select#"+child_id)[0].onchange();
            }
        });
    };
}

function add_to_cart(material_id, guild_id) {
	$.ajax({
		dataType: "json",
		cache: false,
		url: '/materials/'+material_id+'/add_to_cart?',
    data: "guild_id=" + guild_id,
		timeout: 2000,
		error: function(XMLHttpRequest, errorTextStatus, error){
			// flash error message
			$('#ajax_errors').append("Failed to submit : "+ errorTextStatus+" ;"+error)
		},
		success: function(data){
			// flash success message
			$('#ajax_messages').append("Material added to cart")
		}
	});
}
