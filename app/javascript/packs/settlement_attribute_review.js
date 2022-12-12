// Buttons have the name format [approve/reject]-[key]-button
// So for example, a button to reject the amount attribute would have the name "reject-amount-button" (assuming the key is correctly set to "amount")
// 
// Modals have the name format [key]-modal
// So for example, the change password modal would have the name "change-password-modal" (assuming the key is set to "change-password")

import EnglishLanguage from "./english_language";

const KEYS = {
    AMOUNT:             "amount",
    CLAIMANT_NAME:      "claimant-name",
    POLICY_HOLDER_NAME: "policy-holder-name",
    INCIDENT_LOCATION:  "incident-location",
    INCIDENT_DATE:      "incident-date",
    CLAIM_NUMBER:       "claim-number",
    POLICY_NUMBER:      "policy-number"
}

export default class AttributeReview {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            AttributeReview.initApprovalButtons();
            AttributeReview.initRejectionButtons();
            AttributeReview.initApproveAllButton();
        });
    }

    static initApproveAllButton() {
        let approve_all_button = document.getElementsByName("approve-all-attributes-button")[0];
        approve_all_button.addEventListener("click", async (e) =>{
            e.preventDefault();
            AttributeReview.replaceAllApprovalButtonsWithWaitingIndicators();
            let publicId = approve_all_button.getAttribute("for");
            let bodyContent = {
                authenticity_token: document.getElementsByName("attribute-review-authenticity-token")[0].getAttribute("value"),
                public_id: publicId
            }
            for(var KEY in KEYS) {
                bodyContent[EnglishLanguage.snakeCaseString(KEYS[KEY]) + "_approved"] = true;
            }
            let url = "/settlement_attribute_reviews/" + publicId + "/update"
            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(bodyContent)
            }).then(res => {
                console.log("FIRST then block");
                console.log("res=%O", res);
                if (res.status == 204) {
                    // Replace the waiting indicators with rejection buttons
                    AttributeReview.replaceAllWaitingIndicatorsWithRejectionButtons();
                } else {
                    AttributeReview.replaceAllWaitingIndicatorsWithApprovalButtons()
                    // Replace the waiting indicator with the original button
                }
                return res;
            }).catch(error => {
                // AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, approval_buttons[i]);
                // Replace the waiting indicator with the original button
                console.log("ERROR block! error=%O", error);
            });
        });
    }

    static initApprovalButtons() {
        for(var KEY in KEYS) {
            let approval_buttons = document.getElementsByName(AttributeReview.approvalButtonName(KEYS[KEY]));
            if (approval_buttons.length == 0) {
                continue;
            } else {
                // storing key in memory so it can be accessed by the anonymous function in the button event-listener when it's called.
                const key = KEYS[KEY];
                for (let i = 0; i < approval_buttons.length; i++) {
                    console.log("buttons[%s]=%O", i, approval_buttons[i]);
                    var publicId = approval_buttons[i].getAttribute("for")
                    let complimentary_button = document.getElementsByName(AttributeReview.rejectionButtonName(key))[0]
                    console.log("publicId=%s", publicId)
                    approval_buttons[i].addEventListener("click", async (e) => {
                        e.preventDefault();
                        let waitingIndicatorElement = AttributeReview.replaceButtonWithWaitingIndicator(approval_buttons[i]);
                        console.log("Click registered!");
                        let bodyContent = {
                            authenticity_token: document.getElementsByName("attribute-review-authenticity-token")[0].getAttribute("value"),
                            public_id: publicId
                        }
                        bodyContent[EnglishLanguage.snakeCaseString(key) + "_approved"] = true;
                        let url = "/settlement_attribute_reviews/" + publicId + "/update"
                        console.log("bodyContent=%O", bodyContent);
                        const response = await fetch(url, {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify(bodyContent)
                        }).then(res => {
                            console.log("FIRST then block");
                            console.log("res=%O", res);
                            if (res.status == 204) {
                                // Replace the waiting indicator with the complimentary button
                                AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, complimentary_button)
                            } else {
                                AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, approval_buttons[i])
                                // Replace the waiting indicator with the original button
                            }
                            return res;
                        }).catch(error => {
                            AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, approval_buttons[i]);
                            // Replace the waiting indicator with the original button
                            console.log("ERROR block");
                        });
                    });
                }
            }
        }
    }

    static initRejectionButtons() {
        for(var KEY in KEYS) {
            let rejection_buttons = document.getElementsByName(AttributeReview.rejectionButtonName(KEYS[KEY]));
            if (rejection_buttons.length == 0) {
                continue;
            } else {
                // storing key in memory so it can be accessed by the anonymous function in the button event-listener when it's called.
                const key = KEYS[KEY];
                for (let i = 0; i < rejection_buttons.length; i++) {
                    console.log("buttons[%s]=%O", i, rejection_buttons[i]);
                    var publicId = rejection_buttons[i].getAttribute("for")
                    let complimentary_button = document.getElementsByName(AttributeReview.approvalButtonName(key))[0]
                    console.log("publicId=%s", publicId)
                    rejection_buttons[i].addEventListener("click", async (e) => {
                        e.preventDefault();
                        let waitingIndicatorElement = AttributeReview.replaceButtonWithWaitingIndicator(rejection_buttons[i]);
                        console.log("Click registered!");
                        let bodyContent = {
                            authenticity_token: document.getElementsByName("attribute-review-authenticity-token")[0].getAttribute("value"),
                            public_id: publicId
                        }
                        bodyContent[EnglishLanguage.snakeCaseString(key) + "_approved"] = false;
                        let url = "/settlement_attribute_reviews/" + publicId + "/update"
                        console.log("bodyContent=%O", bodyContent);
                        const response = await fetch(url, {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify(bodyContent)
                        }).then(res => {
                            console.log("FIRST then block");
                            console.log("res=%O", res);
                            if (res.status == 204) {
                                // Replace the waiting indicator with the complimentary button
                                AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, complimentary_button)
                            } else {
                                AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, rejection_buttons[i])
                                // Replace the waiting indicator with the original button
                            }
                            return res;
                        }).catch(error => {
                            AttributeReview.replaceWaitingIndicatorWithButton(waitingIndicatorElement, rejection_buttons[i]);
                            // Replace the waiting indicator with the original button
                            console.log("ERROR block");
                        });
                        console.log("response.code=%O", response.code)
                    });
                }
            }
        }
    }

    static replaceAllApprovalButtonsWithWaitingIndicators() {
        for(var KEY in KEYS) {
            let button = document.getElementsByName(AttributeReview.approvalButtonName(KEYS[KEY]))[0];
            if (button != null) {
                AttributeReview.replaceButtonWithWaitingIndicator(button);
            }
        }
    }

    static replaceAllWaitingIndicatorsWithRejectionButtons() {
        for(var KEY in KEYS) {
            let waitingIndicator = document.getElementsByName(AttributeReview.waitingIndicatorName(KEYS[KEY]))[0];
            let button = document.getElementsByName(AttributeReview.rejectionButtonName(KEYS[KEY]))[0];
            if (waitingIndicator != null) {
                waitingIndicator.remove();
            }
            if(button != null) {
                button.style.display = "block";
            }
        }
    }

    static replaceAllWaitingIndicatorsWithApprovalButtons() {
        for(var KEY in KEYS) {
            let waitingIndicator = document.getElementsByName(AttributeReview.waitingIndicatorName(KEYS[KEY]))[0];
            let button = document.getElementsByName(AttributeReview.approvalButtonName(KEYS[KEY]))[0];
            if (waitingIndicator != null) {
                waitingIndicator.remove();
            }
            if(button != null) {
                button.style.display = "block";
            }
        }
    }

    static replaceButtonWithWaitingIndicator(buttonElement) {
        console.log(typeof buttonElement);
        console.log("Entered method replaceButtonWithWaitingIndicator(). buttonElement=%s", buttonElement);
        if (buttonElement.style.display == "none") {
            return;
        }
        let parentElement = buttonElement.parentElement;
        let waitingIndicatorElement = document.createElement("i");
        let buttonWrapper = document.createElement("button");

        buttonWrapper.classList.add("btn", "p-0", "d-flex", "align-items-center");
        waitingIndicatorElement.classList.add("fa-solid", "fa-circle", "m-0", "text-muted", "h6");

        buttonWrapper.appendChild(waitingIndicatorElement);
        buttonWrapper.setAttribute("name", AttributeReview.waitingIndicatorName(buttonElement.getAttribute("name").replace("approve-", "").replace("reject-", "").replace("-button", "")));
        parentElement.insertBefore(buttonWrapper, buttonElement);
        buttonElement.style.display = "none";
        console.log("Left method replaceButtonWithWaitingIndicator()");
        return buttonWrapper;
    }

    static replaceWaitingIndicatorWithButton(waitingIndicatorElement, buttonElement) {
        console.log("Entered method replaceWaitingIndicatorWithButton(). buttonElement=%O". buttonElement);
        waitingIndicatorElement.remove();
        buttonElement.style.display = "block";
        console.log("Left method replaceWaitingIndicatorWithButton()");
    }

    static rejectionButtonName(key) {
        return "reject-" + key + "-button";
    }

    static approvalButtonName(key) {
        return "approve-" + key + "-button";
    }

    static waitingIndicatorName(key) {
        return "waiting-for-" + key + "-indicator"
    }
}