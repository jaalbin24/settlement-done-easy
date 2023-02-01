import FormErrorStyling from "../packs/form_error_styling";

export default class CardValidator {
    constructor(form) {
        this.initEventListeners(form);
    }

    validateExpiration() {
        return {
            valid: false,
            message: ""
        }
    }

    validateNumber(cardNum) {
        var reversedCardNum = cardNum.split('').reverse().map(function (digit) {
            return parseInt(digit);
        });
        // perform the Luhn calculation
        var sum = 0;
        for (var i = 0; i < reversedCardNum.length; i++) {
            var digit = reversedCardNum[i];
            if (i % 2 === 0) {
                // double every second digit
                digit *= 2;
                if (digit > 9) {
                    // subtract 9 from digits greater than 9
                    digit -= 9;
                }
            }
            sum += digit;
        }
        // check if the sum is divisible by 10
        if (sum % 10 === 0) {
            return {
                valid: true,
                message: ""
            }
        } else {
            return {
                valid: false,
                message: "This is not a valid card number."
            }
        }
    }

    validateCVC() {
        return {
            valid: false,
            message: ""
        }
    }

    buildAndSubmit() {

    }

    initEventListeners(form) {
        let expirationField = form.querySelector("input#card_expiration");
        let cvcField = form.querySelector("input#card_cvc");
        this.initCardNumberEventListeners(form);

    }

    initCardNumberEventListeners(form) {
        let numberField = form.querySelector("input#card_number");
        numberField.addEventListener("input", (e) => {
            FormErrorStyling.removeErrorFromInput(numberField);
            let cardNum = e.target.value.replaceAll(/\s/g, "");
            // If the card number contains letters
            if (/[^0-9]/.test(cardNum)) {
                if (cardNum.replaceAll(/[^0-9]/g, '').length === 0) {
                    e.target.value = "";
                } else {
                    e.preventDefault();
                    e.target.value = cardNum.replaceAll(/[^0-9]/g, '').match(/.{1,4}/g).join(' ');
                }
            } else if (cardNum.length >= 5) {
                e.preventDefault();
                e.target.value = cardNum.match(/.{1,4}/g).join(' ');
                if (cardNum.length > 16) {
                    e.preventDefault();
                    e.target.value = cardNum.substring(0, cardNum.length-1).match(/.{1,4}/g).join(' ');
                }
            }
        });
        numberField.addEventListener("blur", (e) => {
            let cardNum = e.target.value.replaceAll(/\s/g, "");
            if (cardNum.length === 16) {
                let result = this.validateNumber(cardNum);
                if (result.valid) {
                    
                } else {
                    FormErrorStyling.styleInputAsInvalid(numberField, result.message);
                }
            }
        });
    }
    initCardExpirationEventListeners() {
        
    }
    initCardCvcEventListeners() {
        
    }
}