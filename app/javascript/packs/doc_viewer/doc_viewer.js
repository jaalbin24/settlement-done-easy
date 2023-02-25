import { instanceOf } from "prop-types";
import Document from "packs/doc_viewer/document";

export default class DocViewer {

    // Create the DocViewer container
    constructor() {
        this.docViewerEl = document.getElementById('doc-viewer');
        
        document.createElement('div');
        this.docViewerEl.setAttribute('id', 'doc-viewer');
        this.docViewerEl.classList.add('hidden', 'hide');
        document.body.append(this.docViewerEl);

        let exitButton = document.createElement('button')
        exitButton.classList.add('btn', 'btn-lg', 'position-fixed');
        exitButton.style.right = '3px';
        exitButton.style.right = '3px';

        // <button class="btn btn-lg position-fixed" style="right: 3px; top: 3px;" type="button"><%=x_icon(color: "#ffffff", size: 30)%></button>

        this.documents = [];
        this.initEventListeners();
    }

    // Takes a document's public id (string) or a Document object as input
    // Opens the Document Viewer showing the document whose public id is
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