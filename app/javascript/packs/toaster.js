const TOAST_TEMPLATE = `
    <div class="toast show" role="alert" data-bs-autohide="false" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <span class="bs-toaster-icon d-flex text-primary"><i class="fa-solid fa-circle-info"></i></span>
            <strong class="bs-toaster-title ms-1 me-auto">%TITLE%</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="bs-toaster-text toast-body">
            %MESSAGE%
        </div>
    </div>
`;

const TOAST_CONTAINER_ID = "toast-container";

export default class Toaster {
    constructor(e) {

    }

    createAndRender(title, message) {
        var toastContainerEl = document.getElementById(TOAST_CONTAINER_ID);
        toastContainerEl.insertAdjacentHTML("afterbegin", TOAST_TEMPLATE.trim());
        var toastEl = toastContainerEl.querySelector(".toast")
        toastEl.querySelector(".bs-toaster-title").innerHTML = title;
        toastEl.querySelector(".bs-toaster-text").innerHTML = message;
        var toast = new bootstrap.Toast(toastContainerEl, {autohide: false});
        toast.show();
    }
}