// Buttons have the name format [open/close]-[key]-button
// So for example, a button to open the payment confirmation modal would have the name "open-payment-confirmation-button" (assuming the key is set to "payment-confirmation")
// 
// Modals have the name format [key]-modal
// So for example, the change password modal would have the name "change-password-modal" (assuming the key is set to "change-password")

const KEYS = {
    PAYMENT_CONFIRMATION:           "payment-confirmation",
    PAYMENT_REQUEST_CONFIRMATION:   "payment-request-confirmation",
    DOCUMENT_REJECT_CONFIRMATION:   "document-reject-confirmation",
    DOCUMENT_UPLOAD:                "document-upload",
    CHANGE_PASSWORD:                "change-password"
}

export default class ModalMaker {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            for(var KEY in KEYS) {
                let buttons = document.getElementsByName(ModalMaker.buttonName(KEYS[KEY]));
                if (buttons.length == 0) {
                    continue;
                } else {
                    // storing key in memory so it can be accessed by the anonymous function in the button event-listener when it's called.
                    var key = KEYS[KEY];
                    for (let i = 0; i < buttons.length; i++) {
                        console.log("buttons[%s]=%O", i, buttons[i]);
                        buttons[i].addEventListener("click", (e) => {
                            e.preventDefault();
                            console.log("Click registered!");
                            ModalMaker.renderModalWithName(ModalMaker.modalName(key));
                        });
                    }
                }
            }
        });
    }

    // hideActiveModal() will throw an error if no modal is currently shown.
    static hideActiveModal() {
        var activeModalEl = document.querySelector(".modal.show");
        if (activeModalEl == null) {
            return null;
        }
        console.log("Closing modal: %O", activeModalEl);
        var activeModal = bootstrap.Modal.getOrCreateInstance(activeModalEl);
        ModalMaker.submitFormInModalEl(activeModalEl);
        activeModal.hide();
        return activeModalEl;
    }

    static activeModal() {
        var activeModalEl = document.querySelector(".modal.show");
        if (activeModalEl == null) {
            return null;
        } else {
            return bootstrap.Modal.getOrCreateInstance(activeModalEl);
        }
    }

    static renderModalWithName(name) {
        console.log("rendering modal with name=%s", name);
        if (ModalMaker.activeModal() == null) {
            console.log("rendering fresh modal");
            bootstrap.Modal.getOrCreateInstance(document.getElementsByName(name)[0]).show();
        } else {
            console.log("closing active modal then rendering new modal");
            ModalMaker.hideActiveModal().addEventListener("hidden.bs.modal", () => {
                bootstrap.Modal.getOrCreateInstance(document.getElementsByName(name)[0]).show();
            });
        }
    }

    // static submitFormInModalEl(modalEl) {
    //     var formEl = modalEl.getElementsByTagName("form")[0];
    //     if (formEl == null) {
    //         return null;
    //     }
    //     formEl.submit();
    //     console.log("User settings form submitted!");
    // }

    static modalName(key) {
        return key + "-modal";
    }

    static buttonName(key) {
        return "open-" + key + "-button";
    }
}

