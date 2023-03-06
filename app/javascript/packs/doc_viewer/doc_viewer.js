import { instanceOf } from "prop-types";
import Document from "packs/doc_viewer/document";
import ButtonBar from "packs/doc_viewer/button_bar";
import Canvas from "packs/doc_viewer/canvas";

export default class DocViewer {

    // Create the DocViewer container
    constructor() {
        this.docViewerEl = document.getElementById('doc-viewer');
        this.documents = [];
        this.buttonBar = new ButtonBar(this);
        this.canvas = new Canvas();
        this.initEventListeners();
        this.boundInitSigForm = this.initSigForm.bind(this);
        this.boundSubmitSigForm = this.submitSigForm.bind(this);
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
        this.setMode('default');
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
                this.setMode(modeChanger.getAttribute("data-dv-change-mode"));
            });
        }
    }
    /***********************
        Types of modes:
        - default
        - drawSig
        - sendSig
    ***********************/
    setMode(newMode) {
        console.log(`Setting new mode: ${newMode}`)
        this.buttonBar.setMode(newMode);
        this.canvas.setMode(newMode);

        let newSigForm = document.querySelector("form[id='new_signature']");
        let newSigSubmitButton = newSigForm.querySelector("input[type='submit']");
        if(newMode === 'sendSig') {
            newSigSubmitButton.addEventListener('click', this.boundInitSigForm);
        } else {
            newSigSubmitButton.removeEventListener('click', this.boundInitSigForm);
        }
    }

    getDocument(doc_public_id) {
        return this.documents.find(doc => doc.public_id === doc_public_id);
    }

    initSigForm(e) {
        let form = e.currentTarget.form;
        // form.addEventListener('submit', this.boundSubmitSigForm);
        form.querySelector("input[name='signature[corner1_x]']").setAttribute('value', this.canvas.sigCorner1[0]);
        form.querySelector("input[name='signature[corner1_y]']").setAttribute('value', this.canvas.sigCorner1[1]);
        form.querySelector("input[name='signature[corner2_x]']").setAttribute('value', this.canvas.sigCorner2[0]);
        form.querySelector("input[name='signature[corner2_y]']").setAttribute('value', this.canvas.sigCorner2[1]);
        form.querySelector("input[name='doc_public_id']").setAttribute('value', this.currentDocument.public_id);
        form.submit();
        e.currentTarget.removeEventListener('click', this.boundInitSigForm);
    }

    // async submitSigForm(e) {
    //     e.preventDefault();
    //     let form = e.currentTarget;
    //     const formData = new FormData(form);
    //     const response = await fetch(form.action, {
    //         method: form.method,
    //         body: formData,
    //     });
    //     const statusCode = response.status;
    //     if (statusCode == 204) {

    //     } else {
    //         this.setMode('sigStatus');
    //     }
    //     console.log(statusCode);
    // }
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
    console.log(`DocViewer: addHiddenClass(), propertyName = ${e.propertyName}`);
    if (e.propertyName !== 'opacity') {
        return;
    }
    e.currentTarget.classList.add('hidden');
    e.currentTarget.removeEventListener("transitionend", addHiddenClass);
}