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

// ModalMaker is the class that handles the big modal notifications that appear in the center of the screen and blur the background.
import ModalMaker from 'packs/modal_maker'


import FormErrorStyling from 'packs/form_error_styling'
import MutuallyExclusiveFormElements from 'packs/mutually_exclusive_form_elements'

import AttributeReview from 'packs/settlement_attribute_review'
import EnglishLanguage from 'packs/english_language'

// Instantiate objects to call methods on such as bootstrap.Modal()
window.bootstrap = require('bootstrap');
window.modalMaker = new ModalMaker();
window.settlementAttributeReview = new AttributeReview();
window.englishLanguage = new EnglishLanguage();
window.formErrorStyling = new FormErrorStyling();
window.mefe = new MutuallyExclusiveFormElements();

// For bootstrap popovers
document.addEventListener("DOMContentLoaded", () => {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });    
})




