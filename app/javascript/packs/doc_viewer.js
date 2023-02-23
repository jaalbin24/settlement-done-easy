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
        let enterers = document.querySelectorAll("[data-dv-enter-sig-mode]");
        for (const enterer of enterers) {
            enterer.addEventListener("click", ()=>{
                DocViewer.enterSignatureMode(enterer.getAttribute("data-dv-enter-sig-mode"));
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
        let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        docViewer.style.opacity = 0;
        docViewer.style.visibility = "hidden";
        document.body.style.overflow = "auto";
        document.removeEventListener('keydown', DocViewer.handleKeyDown);
    }

    static open(doc_public_id) {
        let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        docViewer.style.opacity = 1;
        docViewer.style.visibility = "visible";
        document.body.style.overflow = "hidden";
        document.addEventListener('keydown', DocViewer.handleKeyDown);
    }

    static enterSignatureMode(doc_public_id) {
        let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
        let buttonBar = docViewer.querySelector("[data-dv-button-bar]");
        let barContainer = docViewer.querySelector("[data-dv-bar]");
        let drawBar = docViewer.querySelector("[data-dv-draw-bar]");

        // Get size of draw bar
        drawBar.classList.remove('hidden');
        buttonBar.classList.add('hidden');
        let plannedWidth = drawBar.clientWidth + 20 + 'px';
        let plannedHeight = drawBar.clientHeight + 20 + 'px';
        buttonBar.classList.remove('hidden');
        drawBar.classList.add('hidden');
        barContainer.style.width = barContainer.offsetWidth + 'px';
        barContainer.style.height = barContainer.offsetHeight + 'px';

        buttonBar.addEventListener('transitionend', (e)=>{
            if (e.propertyName !== 'opacity') {
                return;
            }
            console.log(`property=${e.propertyName}`);
            barContainer.style.height = plannedHeight;
            barContainer.style.width = plannedWidth;
            drawBar.classList.remove('hidden');
            barContainer.addEventListener('transitionend', (e) => {
                console.log(`property2=${e.propertyName}`);
                if (e.propertyName !== 'width') {
                    return;
                }
                buttonBar.classList.add('hidden');
                drawBar.classList.remove('hide');
            });
        });
        buttonBar.classList.add('hide');
        setTimeout(() => {
            
        }, 10)
        
    }
}