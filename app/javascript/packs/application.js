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


// Instantiates bootstrap as an object to call methods on such as bootstrap.Modal()
window.bootstrap = require('bootstrap');


// For bootstrap popovers
document.addEventListener("DOMContentLoaded", () => {
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })
})




