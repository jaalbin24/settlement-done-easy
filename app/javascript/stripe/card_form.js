import CardValidator from "../stripe/card_validator";

document.addEventListener("DOMContentLoaded", () => {
    let newCardForm = document.querySelector("form#new_card");
    new CardValidator(newCardForm);
});
