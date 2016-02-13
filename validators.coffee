# Bootstrap 4 style error customizations
$.validator.setDefaults
  highlight: (element) ->
    $(element).closest('.form-group').addClass 'has-danger'
    $(element).addClass 'form-control-danger'
    return
  unhighlight: (element) ->
    $(element).closest('.form-group').removeClass 'has-danger'
    $(element).removeClass 'form-control-danger'
    return
  errorElement: 'small'
  errorClass: 'text-muted'

# Validate Card Number
$.validator.addMethod 'validCardNumber', ((value, element) ->
  @optional(element) or $.payment.validateCardNumber(value)
), 'You must enter a valid card number'

# Validate Exp Date
$.validator.addMethod 'validExpDate', ((value, element) ->
  expObj = $.payment.cardExpiryVal(value)
  isValid = $.payment.validateCardExpiry(expObj.month, expObj.year)
  @optional(element) or isValid
), 'You must enter a valid expiration date'

# Validate Card CVC
$.validator.addMethod 'validCardCVC', ((value, element) ->
  @optional(element) or $.payment.validateCardCVC(value)
), 'You must enter a valid CV code'

# Form Validator Example
$('#sub-form').validate
  rules:
    card_number:
      required: true
      validCardNumber: true
    card_name: required: true
    card_exp:
      required: true
      validExpDate: true
    card_cvc:
      required: true
      validCardCVC: true
  messages:
    card_number: required: 'You must enter a card number'
    card_name: required: 'You must enter the full name on the card'
    card_exp: required: 'You must enter an expiration date'
    card_cvc: required: 'You must enter a CV code'
