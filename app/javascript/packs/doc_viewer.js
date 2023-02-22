export default class DocViewer {
    constructor() {
        document.addEventListener("DOMContentLoaded", ()=>{
            this.initEventListeners();
        });
    }

    initEventListeners() {
        let openers = document.querySelectorAll("[data-dv-open]");
        for (const opener of openers) {
            opener.addEventListener("click", ()=>{
                DocViewer.open(opener.getAttribute("data-dv-open"));
            });
        }
        let closers = document.querySelectorAll("[data-dv-close]");
        for (const closer of closers) {
            closer.addEventListener("click", ()=>{
                DocViewer.close(closer.getAttribute("data-dv-close"));
            });
        }
    }

    static handleKeyDown(event) {
        console.log(`HERE 1 ${event.key}`);
        const key = event.key;
        let docViewer = document.querySelector(`[data-dv-id][style='opacity: 1; visibility: visible;']`);
        console.log(`HERE 2 ${docViewer}`);
        if (key === 'ArrowUp') {
            docViewer.querySelector(".overflow-auto").scrollBy(0, -50);
        } else if (key === 'ArrowDown') {
            docViewer.querySelector(".overflow-auto").scrollBy(0, 50);
        } else if (key === 'Escape') {
            DocViewer.close(docViewer.getAttribute('data-dv-id'));
        }
    }

    static close(doc_public_id) {
        docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        docViewer.style.opacity = 0;
        docViewer.style.visibility = "hidden";
        document.body.style.overflow = "auto";
        document.removeEventListener('keydown', DocViewer.handleKeyDown);
    }

    static open(doc_public_id) {
        docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        docViewer.style.opacity = 1;
        docViewer.style.visibility = "visible";
        document.body.style.overflow = "hidden";
        document.addEventListener('keydown', DocViewer.handleKeyDown);
    }
}