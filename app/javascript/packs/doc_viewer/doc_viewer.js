import { instanceOf } from "prop-types";
import Document from "packs/doc_viewer/document";
import ButtonBar from "packs/doc_viewer/button_bar";
import Canvas from "packs/doc_viewer/canvas";

export default class DocViewer {

    // Create the DocViewer container
    constructor() {
        this.docViewerEl = document.getElementById('doc-viewer');
        this.documents = [];
        this.buttonBar = new ButtonBar();
        this.canvas = new Canvas();
        this.initEventListeners();
    }

    // Takes a document's public id (string) or a Document object as input
    // Opens the Document Viewer showing the document provided
    open(doc) {
        if (doc == null) {
            console.error("IT'S NULL");
            return;
        }
        if (typeof doc === 'string') {
            let newDoc = this.createDocument(doc);
            this.loadDocument(newDoc);
        } else if (doc instanceof Document) {
            this.loadDocument(doc);
        } else {
            console.error(`What is document? ${doc}`);
            return false;
        }
        this.docViewerEl.classList.remove('hidden');
        setTimeout(() => {
            this.docViewerEl.classList.remove('hide');
        }, 10);
        document.body.style.overflow = 'hidden';
    }

    close() {
        this.docViewerEl.addEventListener("transitionend", addHiddenClass);
        console.log(`Added event listener to %O, this=%O`, this, this);
        this.docViewerEl.classList.add('hide');
        document.body.style.overflow = 'auto';
    }

    // Takes a Document object as input.
    // Assigns that Document object as the current document.
    // Unassigns the previous current document.
    loadDocument(doc) {
        if (this.currentDocument != null && this.currentDocument !== doc) {
            this.currentDocument.hide();
        }
        this.docViewerEl.append(doc.documentEl);
        doc.show();
        this.currentDocument = doc;
    }

    // Takes a document's public id (string) as input.
    // Returns a new Document object if a document with that public_id does NOT already exist.
    // Returns the preexisting Document object if a document with that public_id already exists.
    createDocument(doc_public_id) {
        let existingDocument = this.getDocument(doc_public_id);
        if (existingDocument == null) {
            let doc = new Document(doc_public_id);
            this.documents.push(doc);
            return doc;
        } else {
            return existingDocument;
        }
    }

    initEventListeners() {
        let openers = document.querySelectorAll("[data-dv-open]");
        for (const opener of openers) {
            opener.addEventListener("click", open.bind(this));
        }
        let closer = document.querySelector("[data-dv-close]");
        closer.addEventListener("click", close.bind(this));
        let modeChangers = document.querySelectorAll("[data-dv-change-mode]");
        for (const modeChanger of modeChangers) {
            modeChanger.addEventListener("click", () => {
                // DocViewer.close(modeChanger.getAttribute("data-dv-close"));
            });
        }
    }
    /***********************
        Types of modes:
        - Default
        - DrawSig
        - SendSig
    ***********************/
    setMode(newMode) {
        this.buttonBar.setMode(newMode);
        this.canvas.setMode(newMode);
    }

    getDocument(doc_public_id) {
        return this.documents.find(doc => doc.public_id === doc_public_id);
    }
}

function open(e) {
    this.open(e.currentTarget.getAttribute("data-dv-open"));
    console.log("open");
}
function close() {
    this.close();
    console.log("close");
}
function addHiddenClass(e) {
    console.log(e.propertyName);
    if (e.propertyName !== 'opacity') {
        return;
    }
    e.currentTarget.classList.add('hidden');
    e.currentTarget.removeEventListener("transitionend", addHiddenClass);
}