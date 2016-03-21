$(document).ready(function(){
	Stripe.setPublishableKey($(meta[name="stripe-key"]).attr('content'));
	// watch for a form sub,ission
	$("#form-submit-btn").click(function(event){
		event.preventDefault();
		$('input[type=submit]').prop('disabled', true); // disable button to prevent user from clicking twice
		var error = false;
		var ccNum = $('#card_number').val();
		    cvcNum = $('#card_code').val();
		    expMonth = $('#card_month').val();
		    expYear = $('#card_year').val();

		if (!error) {
			// get the stripe token:
			Stripe.createToken({
				number: ccNum,
				cvc: cvcNum,
				exp_month: expMonth,
				exp_year: expYear
			}, stripeResponseHandler);				
		}
		return false;
	});

	function stripeResponseHandler(status, response) {
		// get a reference to the form;
		var f = $("#new_user");

		// get the token from the response:
		var token = response.id;

		// Add the token to the form ;
		f.append('<input type="hidden" name="user[stripe_card_token]" value="' + token '" />');

		// submit the form:
		f.get(0).submit();
	}
});