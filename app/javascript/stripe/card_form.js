import CardValidator from "../stripe/card_validator";

document.addEventListener("DOMContentLoaded", () => {
    let newCardForm = document.querySelector("form#new_card");
    if (newCardForm == null) {
        return;
    }
    new CardValidator(newCardForm);
    var animatedEls = document.querySelectorAll(".animated-width[name='card_icon_container']");
    for (const i of animatedEls) {
        i.addEventListener('transitionend', (e) => {
            if (i.style.width == "0px") {
                i.style.visibility = "hidden";
            } else {
                i.style.visibility = "visible";
            }
        });
        i.style.width = `42px`;
    }
});
