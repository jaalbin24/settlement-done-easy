// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import 'bootstrap'
import 'bootstrap-icons/font/bootstrap-icons.css'
import 'autosize'
import 'stripe/bank_account'

// Toaster is the class that handles the cute toast notifications that appear in the corner of the screen.
import Toaster from 'packs/toaster'

// ModalMaker is the class that handles the big modal notifications that appear in the center of the screen and blur the background.
import ModalMaker from 'packs/modal_maker'


import PasswordConfirmation from 'packs/password_confirmation'

import AttributeReview from 'packs/settlement_attribute_review'
import EnglishLanguage from 'packs/english_language'

// Instantiate objects to call methods on such as bootstrap.Modal()
window.bootstrap = require('bootstrap');
window.toaster = new Toaster();
window.modalMaker = new ModalMaker();
window.settlementAttributeReview = new AttributeReview();
window.englishLanguage = new EnglishLanguage();
window.passwordConfirmation = new PasswordConfirmation();

// For bootstrap popovers
document.addEventListener("DOMContentLoaded", () => {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });    
})




