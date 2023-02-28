export default class Canvas {
    constructor() {
        this.pages = document.getElementsByName('page-wrapper');
        this.sigCorner1 = [];
        this.sigCorner2 = [];
        this.clearSigCorners();
        this.setMode('default');
        console.log(`this.pages=${this.pages}`)
    }

    setMode(newMode) {
        this.clearSigCorners();
        switch (newMode) {
            case 'default':
                for (const page of this.pages) {
                    page.classList.remove('dv-canvas');
                }
                break;
            case 'drawSig':
                for (const page of this.pages) {
                    page.classList.add('dv-canvas');
                    page.addEventListener('click', this.plotSigCorner.bind(this));
                }
                break;
            case 'sendSig':
                //
                break;
        }
    }

    plotSigCorner(e) {
        let rect = e.currentTarget.getBoundingClientRect();
        let x = e.clientX - rect.left;
        let y = e.clientY - rect.top;

        let dot = document.createElement('div');
        dot.style.position = 'absolute';
        dot.style.width = '10px';
        dot.style.height = '10px';
        dot.style.backgroundColor = 'red';
        dot.style.left = x + 'px';
        dot.style.top = y + 'px';
        dot.setAttribute('name', 'sigCorner');

        e.currentTarget.appendChild(dot);

        if(this.sigCorner1.length !== 0) {
            this.sigCorner2 = [x, y];
            console.log(`Plotted sig2 at ${this.sigCorner2}`);

            e.currentTarget.removeEventListener('click', this.plotSigCorner.bind(this));
        } else {
            this.sigCorner1 = [x, y];
            console.log(`Plotted sig1 at ${this.sigCorner1}`);
        }
    }

    clearSigCorners() {
        document.querySelectorAll(`[name='sigCorner']`).forEach((elem) => elem.remove());
        this.sigCorner1.length = 0;
        this.sigCorner2.length = 0;
    }
}