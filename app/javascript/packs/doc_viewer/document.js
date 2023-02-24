export default class Document {

    constructor(doc_public_id) {
        this.public_id = doc_public_id;
        this.documentEl = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        if (this.documentEl == null) {
            throw new Error("Document element could not be found.");
        }
        this.pages = [];
    }

    hide() {
        this.documentEl.classList.add('hide');
        this.documentEl.addEventListener("transitionend", addHiddenClass.bind(this.documentEl))
    }

    show() {
        this.documentEl.classList.remove('hidden')
        setTimeout(removeHideClass.bind(this.documentEl), 10)
    }
}


function addHiddenClass(e) {
    if (e.propertyName !== 'opacity') {
        return;
    }
    this.classList.add('hidden');
}

function removeHideClass() {
    this.classList.remove('hide');
}