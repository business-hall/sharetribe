// Custom Javascript functions for Kassi

// Initialize code that is needed for every view
function initialize_defaults(default_text) { 
	$('input.search_field').empty_value(default_text, true, 'default_text');
	$("select.language_select").uniform();
	$('#close_notification_link').click(function() { $('#notifications').slideUp('fast'); });
}

function initialize_login_form() {
	$('#password_forgotten_link').click(function() { $('#password_forgotten').slideToggle('slow'); });
  $('input.text_field:first').focus();
}

function initialize_new_listing_form(fileDefaultText, fileBtnText, locale) {
	$('#help_tags_link').click(function() { $('#help_tags').lightbox_me({centered: true}); });
	$('input.text_field:first').focus();
	$("select.listing_date_select, input:checkbox, input:file").uniform({
		selectClass: 'selector2', 
		fileDefaultText: fileDefaultText, 
		fileBtnText: fileBtnText
	});
	$("#new_listing").validate({
		debug: false,
		rules: {
			"listing[title]": {required: true, minlength: 2}
		}
	});
	translate_validation_messages(locale);
}

function translate_validation_messages(locale) {
	if (locale == "fi") {
		translate_validation_messages_to_finnish();
	}
}

function translate_validation_messages_to_finnish() {
	jQuery.extend(jQuery.validator.messages, {
		required: "Tämä on pakollinen kenttä.",
		remote: "Tässä kentässä on virhe.",
		email: "Anna toimiva sähköpostiosoite.",
		url: "Anna oikeanlainen URL-osoite.",
		date: "Anna päivämäärä oikessa muodossa.",
		dateISO: "Anna päivämäärä oikeassa muodossa (ISO).",
		number: "Annetun arvon pitää olla numero.",
		digits: "Tähän kenttään voit syöttää ainoastaan kirjaimia.",
		creditcard: "Anna oikeantyyppinen luottokortin numero.",
		equalTo: "Antamasi arvot eivät täsmää.",
		accept: "Tiedosto on vääräntyyppinen.",
		maxlength: $.validator.format("Voit syöttää tähän kenttään maksimissaan {0} merkkiä."),
		minlength: $.validator.format("Syötä tähän kenttään vähintään {0} merkkiä."),
		rangelength: $.validator.format("Merkkimäärän tulee olla välillä {0} ja {1}."),
		range: $.validator.format("Kentän arvon tulee olla välillä {0} ja {1}."),
		max: $.validator.format("Arvo voi olla enintään {0}."),
		min: $.validator.format("Arvon täytyy olla vähintään {0}.")
	});
}