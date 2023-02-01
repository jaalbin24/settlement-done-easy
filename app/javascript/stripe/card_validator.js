import FormErrorStyling from "../packs/form_error_styling";

export default class CardValidator {
    static issuers = [
        { issuer: 'VISA', prefixes: ['4'] },
        { issuer: 'Mastercard', prefixes: ['51', '52', '53', '54', '55'] },
        { issuer: 'American Express', prefixes: ['34', '37'] },
        { issuer: 'Discover', prefixes: ['6011', '622126', '622127', '622128', '622129', '62213', '62214', '62215', '62216', '62217', '62218', '62219', '6222', '6223', '6224', '6225', '6226', '6227', '6228', '62290', '62291', '622920', '622921', '622922', '622923', '622924', '622925'] },
        { issuer: 'JCB', prefixes: ['3528', '3529', '353', '354', '355', '356', '357', '358'] },
        { issuer: 'Diners Club', prefixes: ['300', '301', '302', '303', '304', '305', '36', '38'] }
    ];

    
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
            console.log(this.getIssuer(cardNum));
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

    getIssuer(cardNum) {
        var issuer = "Unknown";
        if (cardNum.length === 0) {
            return issuer;
        }
        var matches = 0;
        var potentialIssuer = "";
        for (const hash of CardValidator.issuers) {
            let foundMatch = false;
            let prefixes = hash.prefixes;
            for (const prefix of prefixes) {
                if (prefix.startsWith(cardNum.substring(0, prefix.length))) {
                    console.log(`${hash.issuer}:${prefix} starts with ${cardNum.substring(0, prefix.length)}`);
                    potentialIssuer = hash.issuer;
                    foundMatch = true;
                }
            }
            if (foundMatch) {
                matches += 1;
            }
        }
        if (matches === 1) {
            issuer = potentialIssuer;
        }
        return issuer;
    }
}