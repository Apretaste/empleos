// list of categories
//
var categories = [];
categories['professor'] = 'Profesor';
categories['design'] = 'Diseño';
categories['marketing'] = 'Marketing';
categories['coding'] = 'Programación';
categories['copywrite'] = 'Escritura';
categories['translation'] = 'Traducción';
categories['research'] = 'Investigación';
categories['testing'] = 'Muestreo';
categories['other'] = 'Otro';

// onload 
//
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
});

// send a new chat
//
function chat() {
	// get message and user features
	var message = $('#message').val().trim();
	var toId = $('#message').attr('to');
	var name = $('#message').attr('name');

	// do not allow short messages
	if (message.length < 2) {
		M.toast({html: 'Debe escribir un texto'});
		return false;
	}

	// send the chat
	apretaste.send({
		command: 'TRABAJOS COMMENT',
		data: {to:toId, message:message},
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
		command: 'TRABAJOS DELETE',
		data: {id:id, type:type},
		redirect: false
	});
}
