// export default class DocViewer {
//     constructor() {
//         document.addEventListener("DOMContentLoaded", ()=>{
//             this.initSizes();
//             this.initEventListeners();
//         });
//     }

//     initSizes() {
//         let barContainers = document.querySelectorAll("[data-dv-bar]");
//         for (const barContainer of barContainers) {
//             let rect = barContainer.getBoundingClientRect();
//             barContainer.style.width = rect.width + 'px';
//             barContainer.style.height = rect.height + 'px';
//         }
//     }

//     initEventListeners() {
//         let openers = document.querySelectorAll("[data-dv-open]");
//         for (const opener of openers) {
//             opener.addEventListener("click", ()=>{
//                 DocViewer.open(opener.getAttribute("data-dv-open"));
//             });
//         }
//         let closers = document.querySelectorAll("[data-dv-close]");
//         for (const closer of closers) {
//             closer.addEventListener("click", ()=>{
//                 DocViewer.close(closer.getAttribute("data-dv-close"));
//             });
//         }
//         let enterers = document.querySelectorAll("[data-dv-enter-sig-mode]");
//         for (const enterer of enterers) {
//             enterer.addEventListener("click", ()=>{
//                 DocViewer.enterSignatureMode(enterer.getAttribute("data-dv-enter-sig-mode"));
//             });
//         }
//         let leavers = document.querySelectorAll("[data-dv-leave-sig-mode]");
//         for (const leaver of leavers) {
//             leaver.addEventListener("click", ()=>{
//                 DocViewer.leaveSignatureMode(leaver.getAttribute("data-dv-leave-sig-mode"));
//             });
//         }
//     }

//     static handleKeyDown(event) {
//         console.log(`HERE 1 ${event.key}`);
//         const key = event.key;
//         let docViewer = document.querySelector(`[data-dv-id][style='opacity: 1; visibility: visible;']`);
//         console.log(`HERE 2 ${docViewer}`);
//         if (key === 'ArrowUp') {
//             docViewer.querySelector(".overflow-auto").scrollBy(0, -50);
//         } else if (key === 'ArrowDown') {
//             docViewer.querySelector(".overflow-auto").scrollBy(0, 50);
//         } else if (key === 'Escape') {
//             DocViewer.close(docViewer.getAttribute('data-dv-id'));
//         }
//     }

//     static close(doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         docViewer.style.opacity = 0;
//         docViewer.style.visibility = "hidden";
//         document.body.style.overflow = "auto";
//         document.removeEventListener('keydown', DocViewer.handleKeyDown);
//         DocViewer.leaveSignatureMode(doc_public_id)
//     }

//     static open(doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         docViewer.style.opacity = 1;
//         docViewer.style.visibility = "visible";
//         document.body.style.overflow = "hidden";
//         document.addEventListener('keydown', DocViewer.handleKeyDown);
//     }

//     static enterSignatureMode(doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         let drawBar = docViewer.querySelector("[data-dv-draw-bar]");
//         let pages = docViewer.querySelectorAll("[name='page-wrapper']");
//         for (const page of pages) {
//             page.style.cursor = 'crosshair';
//             page.addEventListener("click", function plotFirstDot(e) {
//                 let rect = page.getBoundingClientRect();
//                 let x = e.clientX - rect.left;
//                 let y = e.clientY - rect.top;
//                 console.log(`Plotted at x=${x} y=${y}`);

//                 let dot = document.createElement('div');
//                 dot.style.position = 'absolute';
//                 dot.style.width = '10px';
//                 dot.style.height = '10px';
//                 dot.style.borderRadius = '50%';
//                 // dot.style.backgroundColor = 'red';
//                 dot.style.left = x + 'px';
//                 dot.style.top = y + 'px';
//                 dot.setAttribute('name', 'signature-corner-1');

//                 page.appendChild(dot);

//                 let rectEl = document.createElement('div');
//                 rectEl.setAttribute('name', 'signature-outline');
//                 rectEl.style.position = 'absolute';
//                 rectEl.style.border = '1px solid red';


//                 page.appendChild(rectEl);
//                 page.addEventListener("mousemove", renderRectangle);
//                 page.addEventListener('mouseleave', function() {                 
//                     rectEl.classList.add("hidden");
//                 });
//                 page.addEventListener("click", function plotSecondDot(e){
//                     let rect = page.getBoundingClientRect();
//                     let x = e.clientX - rect.left;
//                     let y = e.clientY - rect.top;

//                     let dot = document.createElement('div');
//                     dot.style.position = 'absolute';
//                     dot.style.width = '10px';
//                     dot.style.height = '10px';
//                     dot.style.borderRadius = '50%';
//                     // dot.style.backgroundColor = 'red';
//                     dot.style.left = x + 'px';
//                     dot.style.top = y + 'px';

//                     page.appendChild(dot);
//                     page.removeEventListener("mousemove", renderRectangle);
//                 }, {once: true});
//             }, {once: true});
//         }
//         DocViewer.setCurrentBar(drawBar, doc_public_id);
//     }

//     static setCurrentBar(newBar, doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         let currentBar = DocViewer.getCurrentBar(doc_public_id);
//         let barContainer = docViewer.querySelector("[data-dv-bar]");

//         newBar.classList.remove('hidden');
//         let rect = newBar.getBoundingClientRect();
//         let newBarWidth = rect.width + 'px';
//         let newBarHeight = rect.height + 'px';
//         newBar.classList.add('hidden');

//         currentBar.addEventListener('transitionend', function handleA(e) {
//             if (e.propertyName !== 'opacity') {
//                 return;
//             }
//             console.log(`property1=${e.propertyName}`);
//             currentBar.classList.add('hidden');
//             newBar.classList.remove('hidden');
//             barContainer.style.height = newBarHeight;
//             barContainer.style.width = newBarWidth;
//             barContainer.addEventListener('transitionend', function handleB(e) {
//                 if (e.propertyName !== 'width' && e.propertyName !== 'height') {
//                     return;
//                 }
//                 console.log(`property2=${e.propertyName}`);
//                 newBar.classList.remove('hide');
//                 barContainer.removeEventListener('transitionend', handleB);
//             });
//             currentBar.removeEventListener('transitionend', handleA);
//         });
//         currentBar.classList.add('hide');
//     }

//     static getCurrentBar(doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         let barContainer = docViewer.querySelector("[data-dv-bar]");
//         return barContainer.querySelector("[data-dv-button-bar], [data-dv-draw-bar]:not(.hidden)");
//     }

//     static leaveSignatureMode(doc_public_id) {
//         let docViewer = document.querySelector(`[data-dv-id='${doc_public_id}']`);
//         DocViewer.setCurrentBar(docViewer.querySelector("[data-dv-button-bar]"), doc_public_id);
//         let pages = docViewer.querySelectorAll("img");
//         for (const page of pages) {
//             page.style.cursor = 'auto';
//         }
//     }
// }



// function renderRectangle(e) {
//     let docViewer = e.target.closest("[data-dv-id]");
//     let page = e.target.closest("[name='page-wrapper']");
//     let rectEl = docViewer.querySelector("[name='signature-outline']");
//     let rect = page.getBoundingClientRect();
//     let dot = page.querySelector("[name='signature-corner-1']")
//     rectEl.classList.remove("hidden");

//     var width = Math.abs(e.clientX - rect.left - parseInt(dot.style.left, 10));
//     var height = Math.abs(e.clientY - rect.top - parseInt(dot.style.top, 10));

//     rectEl.style.left = Math.min(e.clientX - rect.left, parseInt(dot.style.left, 10)) + 'px';
//     rectEl.style.top = Math.min(e.clientY - rect.top, parseInt(dot.style.top, 10)) + 'px';
//     rectEl.style.width = width + 'px';
//     rectEl.style.height = height + 'px';
// }