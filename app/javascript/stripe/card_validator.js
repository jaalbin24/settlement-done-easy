import FormErrorStyling from "../packs/form_error_styling";

export default class CardValidator {
    static issuers = [
        { issuer: 'visa', prefixes: ['4'] },
        { issuer: 'mastercard', prefixes: ['51', '52', '53', '54', '55'] },
        { issuer: 'amex', prefixes: ['34', '37'] },
        { issuer: 'discover', prefixes: ['6'] },
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
        let nLength = cardNum.length;
        let sum = 0;
        let parity = nLength % 2;

        for (let i = nLength - 1; i >= 0; i--) {
            let digit = parseInt(cardNum[i]);

            if (i % 2 == parity) {
                digit *= 2;
                if (digit > 9) {
                    digit -= 9;
                }
            }

            sum += digit;
        }
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
    validateCVC(cvc) {
        if (cvc.length > 4) {
            return {
                valid: false,
                message: "The CVC must be 4 numbers or less."
            }
        } else if (/[^0-9]/.test(cvc)) {
            return {
                valid: false,
                message: "The CVC must only contain numbers."
            }
        } else {
            return {
                valid: true,
                message: ""
            }
        }
        
    }
    buildAndSubmit(form) {
        let expMonthField = form.querySelector("input[name='card[exp_month]']");
        let expYearField = form.querySelector("input[name='card[exp_year]']");

        let date = form.querySelector("input[name='card[expiration]']").value;
        const [monthString, yearString] = date.split(" / ");

        expMonthField.value = monthString;
        expYearField.value = yearString;
        form.submit();
    }
    initEventListeners(form) {
        this.initCardCvcEventListeners(form);
        this.initCardNumberEventListeners(form);
        this.initCardExpirationEventListeners(form);
        let submitButton = form.querySelector("input[type='submit']");
        submitButton.addEventListener("click", (e) => {
            e.preventDefault();
            this.buildAndSubmit(form);
        });
    }
    initCardNumberEventListeners(form) {
        let numberField = form.querySelector("input#card_number");
        numberField.addEventListener("input", (e) => {
            FormErrorStyling.removeErrorFromInput(e.target);
            let cardNum = e.target.value.replaceAll(/\s/g, "");
            // If the card number contains letters
            if (!/[^0-9]/.test(cardNum)) {
                if (cardNum.replaceAll(/[^0-9]/g, '').length === 0) {
                    e.target.value = "";
                } else {
                    e.target.value = cardNum.replaceAll(/\s/g, '').match(/.{1,4}/g).join(' ');
                }
            } else if (cardNum.length >= 5) {
                e.target.value = cardNum.match(/.{1,4}/g).join(' ');
            }
            if (cardNum.length > 16) {
                console.log("TOO LONG")
                e.target.value = cardNum.substring(0, 16).match(/.{1,4}/g).join(' ');
            }
            this.updateCardIconBand(cardNum);
        });
        numberField.addEventListener("blur", (e) => {
            let cardNum = e.target.value.replaceAll(/\s/g, '');
            if (cardNum.length === 16) {
                let result = this.validateNumber(cardNum);
                if (result.valid) {
                    
                } else {
                    FormErrorStyling.styleInputAsInvalid(numberField, result.message);
                }
            }
        });
    }
    initCardExpirationEventListeners(form) {
        let expirationField = form.querySelector("input#card_expiration");
        expirationField.addEventListener("input", (e) => {
            let input = e.target.value;
            FormErrorStyling.removeErrorFromInput(e.target);
            // If the does not match the format MM/YY
            if (!/^\d{1,2}( \/ \d{2})?$/.test(input)) {
                if (input.replaceAll(/[^0-9]/g, '').length === 0) {
                    e.target.value = "";
                } else if (input.length > 7) {
                    e.target.value = input.substring(0, input.length-1)
                } else if (input[input.length-1] === '/' && input[input.length-2] != ' ') {
                    if (input.replaceAll(/[^0-9]/g, '').length === 1) {
                        e.target.value = `0${input.replaceAll(/[^0-9]/g, '')} / `;
                    } else if (input.replaceAll(/[^0-9]/g, '').length === 2) {
                        e.target.value = `${input.replaceAll(/[^0-9]/g, '')} / `;
                    }
                } else {
                    e.target.value = input.replaceAll(/[^0-9]/g, '').match(/.{1,2}/g).join(' / ');
                }
            } else if (input.length === 1 && parseInt(input.replaceAll(/[^0-9]/g, '')) >= 2) {
                e.target.value = `0${input} / `;
            } else if (input.length === 2 && parseInt(input.replaceAll(/[^0-9]/g, '')) >= 13) {
                e.target.value = `0${input[0]} / ${input[1]}`;
            } else if (input.length === 2 && parseInt(input.replaceAll(/[^0-9]/g, '')) < 13) {
                e.target.value = `${input} / `;
            }
        });
        expirationField.addEventListener("blur", (e) => {
            let date = e.target.value;
            const [monthString, yearString] = date.split(" / ");
            const month = parseInt(monthString);
            const year = parseInt(yearString);

            if (month < 1 || month > 12) {
                FormErrorStyling.styleInputAsInvalid(e.target, "Your card's expiration month is invalid.");
            } else if (year < 0 || year > 99) {
                FormErrorStyling.styleInputAsInvalid(e.target, "Your card's expiration year is invalid.");
            } else {
                let now = new Date();
                if (2000 + year < now.getFullYear()) {
                    FormErrorStyling.styleInputAsInvalid(e.target, "This date is in the past.");
                } else if (2000 + year == now.getFullYear() && month < now.getMonth()) {
                    FormErrorStyling.styleInputAsInvalid(e.target, "This date is in the past.");
                }
            }
        });
    }
    initCardCvcEventListeners(form) {
        let cvcField = form.querySelector("input#card_cvc");
        cvcField.addEventListener("input", (e) => {
            let cvc = e.target.value;
            if (/[^0-9]/.test(cvc)) {
                e.target.value = cvc.replaceAll(/[^0-9]/g, '');
            } else if (cvc.length > 4) {
                e.target.value = cvc.substring(0, 4);
            }
        });
        cvcField.addEventListener("blur", (e) => {
            let cvc = e.target.value;
            let result = this.validateCVC(cvc)
            if (result.valid) {

            } else {
                FormErrorStyling.styleInputAsInvalid(e.target, result.message)
            }
        });
    }
    getIssuer(cardNum) {
        var issuer = "unknown";
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
    updateCardIconBand(cardNum) {
        let issuer = this.getIssuer(cardNum);
        if (issuer === "unknown") {
            let defaultIcons = document.querySelectorAll(".animated-width[name='card_icon_container'][data-default='true']");
            let currentIssuerIcons = document.querySelectorAll(".animated-width[name='card_icon_container'][style='visibility: hidden;']");
            if (defaultIcons == currentIssuerIcons) {
                return;
            } else {
                for (const i of currentIssuerIcons) {
                    if (!Array.from(defaultIcons).includes(i)) {
                        i.style.width = "0px";
                    }
                }
                for (const i of defaultIcons) {
                    i.style.width = "42px";
                    i.style.visibility = "visible";
                }
            }
            return;
        }
        let currentIssuerIcons = document.querySelectorAll(".animated-width[name='card_icon_container']");
        let newIssuerIcon = document.querySelector(`[id='${issuer}_card_icon']`).parent;
        if (currentIssuerIcons.size === 1 && currentIssuerIcons[0] === newIssuerIcon) {
            // Desired active icon is already active
            return;
        } else {
            for (const icon of currentIssuerIcons) {
                if (icon.getAttribute("for") == issuer) {
                    icon.style.width = "42px";
                    icon.style.visibility = "visible";
                    continue;
                }
                icon.style.width = 0;
            }
        }

    }
}
  
