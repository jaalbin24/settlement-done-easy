export default class Canvas {
    constructor() {
        this.pages = document.getElementsByName('page-wrapper');
        this.sigCorner1 = [];
        this.sigCorner2 = [];
        this.clearSigCorners();
        this.boundPlotSigCorner = this.plotSigCorner.bind(this);
        this.boundDrawSigOutline = this.drawSigOutline.bind(this);
        this.setMode('default');
        console.log(`this.pages=${this.pages}`)
    }

    setMode(newMode) {
        this.hideNextButton();
        switch (newMode) {
            case 'default':
                this.clearSigCorners();
                for (const page of this.pages) {
                    page.classList.remove('dv-canvas');
                }
                break;
            case 'drawSig':
                for (const page of this.pages) {
                    page.classList.add('dv-canvas');
                    page.addEventListener('click', this.boundPlotSigCorner);
                }
                break;
            case 'sendSig':
                for (const page of this.pages) {
                    page.classList.remove('dv-canvas');
                }
                break;
        }
    }

    plotSigCorner(e) {
        let rect = e.currentTarget.getBoundingClientRect();
        let x = e.clientX - rect.left;
        let y = e.clientY - rect.top;

        if(this.sigCorner1El != null) {
            this.sigCorner2 = [x, y];
            this.sigCorner2El = document.createElement('div');
            this.sigCorner2El.style.position = 'absolute';
            this.sigCorner2El.style.left = x + 'px';
            this.sigCorner2El.style.top = y + 'px';
            this.sigCorner2El.setAttribute('name', 'sigCorner');
    
            e.currentTarget.appendChild(this.sigCorner2El);

            console.log(`Plotted sig2 at ${this.sigCorner2}`);
            this.showNextButton();

            e.currentTarget.removeEventListener('click', this.boundPlotSigCorner);
            for(const page of this.pages) {
                page.removeEventListener('mousemove', this.boundDrawSigOutline);
            }
            
        } else {
            this.sigCorner1 = [x, y];
            this.sigCorner1El = document.createElement('div');
            this.sigCorner1El.style.position = 'absolute';
            this.sigCorner1El.style.left = x + 'px';
            this.sigCorner1El.style.top = y + 'px';
            this.sigCorner1El.setAttribute('name', 'sigCorner');
    
            e.currentTarget.appendChild(this.sigCorner1El);

            this.sigOutlineEl = document.createElement('div');
            this.sigOutlineEl.setAttribute('name', 'sigOutline');
            this.sigOutlineEl.classList.add('sig-outline', 'fades');
            this.sigOutlineEl.innerHTML = 'The signature will go here.';

            e.currentTarget.appendChild(this.sigOutlineEl);

            for(const page of this.pages) {
                page.addEventListener('mousemove', this.boundDrawSigOutline);
            }
            console.log(`Plotted sig1 at ${this.sigCorner1}`);
        }
    }

    drawSigOutline(e) {
        let rect = e.currentTarget.getBoundingClientRect();

        console.log('MOUSE IS ON THE MOVE');
        var width = Math.abs(e.clientX - rect.left - parseInt(this.sigCorner1El.style.left, 10));
        var height = Math.abs(e.clientY - rect.top - parseInt(this.sigCorner1El.style.top, 10));
        console.log(`e.clientX=${e.clientX}, rect.left=${rect.left}, parseInt(this.sigCorner1El.style.left, 10)=${parseInt(this.sigCorner1El.style.left, 10)}`)

        this.sigOutlineEl.style.left = Math.min(e.clientX - rect.left, parseInt(this.sigCorner1El.style.left, 10)) + 'px';
        this.sigOutlineEl.style.top = Math.min(e.clientY - rect.top, parseInt(this.sigCorner1El.style.top, 10)) + 'px';
        this.sigOutlineEl.style.width = width + 'px';
        this.sigOutlineEl.style.height = height + 'px';
        console.log(`Outline: width=${width}, height=${height}`);
    }

    clearSigCorners() {
        console.warn('CLEARING SIG CORNERS');
        document.querySelectorAll(`[name='sigCorner']`).forEach((el) => el.remove());
        document.querySelectorAll(`[name='sigOutline']`).forEach((el) => {
            el.classList.add('hide');
            el.addEventListener('transitionend', (e)=>{
                if (e.propertyName !== 'opacity') {
                    return;
                }
                console.log('REMOVED THE OUTLINE');
                el.remove();
            });
        });
        this.sigCorner1El = null;
        this.sigCorner2El = null;        
        this.sigOutline = null;        
        this.sigCorner1.length = 0;
        this.sigCorner2.length = 0;
    }

    showNextButton() {
        let nextButtonWrapperEl = document.getElementById('sendSig-wrapper');
        let nextButtonEl = document.querySelector('[data-dv-change-mode="sendSig"]');
        let style = window.getComputedStyle(nextButtonEl);

        let newWidth = nextButtonEl.getBoundingClientRect().width + parseFloat(style.marginLeft) + parseFloat(style.marginRight);
        nextButtonWrapperEl.style.width = newWidth + 'px';
    }

    hideNextButton() {
        let nextButtonWrapperEl = document.getElementById('sendSig-wrapper');
        nextButtonWrapperEl.style.width = '0px';
    }
}