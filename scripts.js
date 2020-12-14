$(document).ready(function() {
	// start components
	$('.tabs').tabs();
	$('.modal').modal();
	$('select').formSelect();

	// set reminder function
	$('.remainder').on('input', function(){
		// get values
		var message = $(this).val().trim();
		var maxlength = $(this).attr('maxlength');
		var counter = $("label[for='" + $(this).attr('id') + "'] span");

		// calculate the reminder
		var remainder = (message.length <= maxlength) ? (maxlength - message.length) : 0;

		// restrict message to maxlength
		if (remainder <= 0) {
			message = message.substring(0, maxlength);
			$(this).val(message);
		}

		// update the counter with the remainder amount
		counter.html(message.length);
	})

	// forms
	$(".ap-form").submit(function(e) {
		e.preventDefault();

		var form = $(this);
		var valid = true;
		var data = getDataForm(form);

		var validator = form.attr('data-validator');
		if (validator)  {
			eval('valid = ' + validator +'(data)');
			if (!valid) return;
		}

		var redirect = form.attr('data-redirect');
		if (typeof redirect === 'undefined') { redirect = true; }
		else redirect = redirect !== 'false';

		var callback = form.attr('data-callback');
		if (typeof callback === 'undefined') callback = null;

		apretaste.send({
			command: form.attr('action'),
			data: data,
			redirect: redirect,
			callback: {name: callback}
		});
	});
});

/**
 *
 * @param form
 * @returns {{}}
 */
function getDataForm(form) {
	var serial = form.serializeArray();
	var data = {};

	for (var field in serial) {
		var fn = serial[field].name;

		if (fn.indexOf('[]') > 0) {
			fn = fn.replace('[]', '');
			if (typeof data[fn] === 'undefined') data[fn] = [];
			data[fn].push(serial[field].value);
		} else {
			data[serial[field].name] = serial[field].value;
		}
	}

	return data;
}

// send a new chat
//
function chat() {
	// get message and user features
	var message = $('#message').val().trim();
	var toId = $('#message').attr('to');
	var name = $('#message').attr('name');
	var offerId = $('#message').attr('name');

	// do not allow short messages
	if (message.length < 2) {
		M.toast({html: 'Debe escribir un texto'});
		return false;
	}

	// send the chat
	apretaste.send({
		command: 'EMPLEOS COMMENT',
		data: {to:toId, message:message, offerId: offerId},
		redirect: false
	});

	// if is the first chat
	$('#msg').hide();

	// append the bubble to teh screen
	$('#chat').append(
		'<li id="last" class="right">' +
		'	<div class="head">' +
		'		<span class="grey-text text-darken-4">' + name + '</span>' +
		'		<span class="date">' +  moment().format('MMM D, YYYY h:mm A') + '</span>' +
		'	</div>' +
		'	<span class="text">' + message + '</span>' +
		'</li>');

	// clean the chat field
	$('#message').val('');

	// scroll to the lastest chat
	$('html, body').animate({
		scrollTop: $("#last").offset().top
	}, 1000);

}

// delete an education or experience
//
function trash(id, type) {
	// delete from the view
	$('#'+type+'-'+id).remove();

	// send delete request
	apretaste.send({
		command: 'EMPLEOS DELETE',
		data: {id:id, type:type},
		redirect: false
	});
}

function toast(message){
	M.toast({html: message});
}

function validateEmail(data) {
	const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (!re.test(data.email)) {
		toast('Introduzca un email valido');
		return false;
	}
	return true;
}

function capitalize (s) {
	if (typeof s !== 'string') return ''
	return s.charAt(0).toUpperCase() + s.slice(1)
}

function newJobValidator(data) {

	if (data.kind.trim() === '') {
		toast("Especifica el tipo de anuncio");
		return false;
	}

	if (data.category.trim() === '') {
		toast("Especifica la cateogor&iacute;a");
		return false;
	}

	return true;
}