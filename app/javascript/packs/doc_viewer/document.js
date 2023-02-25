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
        this.documentEl.classList.add('hidden');
    }

    show() {
        this.documentEl.classList.remove('hidden')
    }
}