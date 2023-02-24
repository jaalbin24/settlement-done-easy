import { instanceOf } from "prop-types";
import Document from "packs/doc_viewer/document";

export default class DocViewer {

    // Create the DocViewer container
    constructor() {
        this.docViewerEl = document.createElement('div');
        this.docViewerEl.setAttribute('id', 'doc-viewer');
        this.docViewerEl.classList.add('hidden', 'hide');
        document.body.append(this.docViewerEl);
        this.documents = [];
        this.initEventListeners();
    }

    // Takes a document's public id (string) or a Document object as input
    // Opens the Document Viewer showing the document whose public id is
    open(document) {
        if (document == null) {
            console.error("IT'S NULL");
            return;
        }
        if (typeof document === 'string') {
            let doc = this.createDocument(document);
            this.loadDocument(doc);
        } else if (document instanceof Document) {
            this.loadDocument(document);
        } else {
            console.error(`What is document? ${document}`);
            return false;
        }
        const {docViewerEl} = this;
        docViewerEl.classList.remove('hidden');
        setTimeout(() => {
            docViewerEl.classList.remove('hide');
        }, 10);
    }

    close() {
        const {docViewerEl} = this;
        docViewerEl.classList.add('hide');
        docViewerEl.addEventListener("transitionend", addHiddenClass.bind(docViewerEl));
    }

    // Takes a Document object as input.
    // Assigns that Document object as the current document.
    // Unassigns the previous current document.
    loadDocument(document) {
        if (this.currentDocument != null) {
            this.currentDocument.hide();
        }
        this.docViewerEl.append(document.documentEl);
        document.show();
        this.currentDocument = document;
    }

    // Takes a document's public id (string) as input.
    // Returns a new Document object if a document with that public_id does NOT already exist.
    // Returns the preexisting Document object if a document with that public_id already exists.
    createDocument(doc_public_id) {
        let existingDocument = this.getDocument(doc_public_id);
        if (existingDocument == null) {
            return new Document(doc_public_id);
        } else {
            return existingDocument;
        }
    }

    initEventListeners() {
        let openers = document.querySelectorAll("[data-dv-open]");
        for (const opener of openers) {
            opener.addEventListener("click", open.bind(this));
        }
        let closers = document.querySelectorAll("[data-dv-close]");
        for (const closer of closers) {
            closer.addEventListener("click", close.bind(this));
        }
        let modeChangers = document.querySelectorAll("[data-dv-change-mode]");
        for (const modeChanger of modeChangers) {
            modeChanger.addEventListener("click", () => {
                // DocViewer.close(modeChanger.getAttribute("data-dv-close"));
            });
        }
    }

    getDocument(doc_public_id) {
        return this.documents.find(doc => doc.public_id === doc_public_id);
    }
}


function open(e) {
    this.open(e.currentTarget.getAttribute("data-dv-open"));
}
function close() {
    this.close();
}
function addHiddenClass(e) {
    if (e.propertyName !== 'opacity') {
        return;
    }
    this.classList.add('hidden');
    e.target.removeEventListener('transitionend', addHiddenClass);
}