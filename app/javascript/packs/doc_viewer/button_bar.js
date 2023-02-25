export default class ButtonBar {
    constructor() {
        this.buttonBarEl = document.querySelector('#button-bar');

        this.defaultEl = document.querySelector('#button-bar-default');
        this.drawSigEl = document.querySelector('#button-bar-draw-sig');
        this.sendSigEl = document.querySelector('#button-bar-send-sig');
        this.currentEl = this.defaultEl;
        this.setMode('default');
    }

    setMode(newMode) {
        console.log(`Setting mode: ${newMode}`);
        if (newMode === this.mode) {
            return;
        }
        switch(newMode) {
            case 'default':
                var newEl = this.defaultEl;
                break;
            case 'drawSig':
                var newEl = this.drawSigEl;
                break;
            case 'sendSig':
                var newEl = this.sendSigEl;
                break;
        }
        this.show(newEl);
        this.currentEl = newEl;
    }

    hide(el) {
        console.log(`Hiding: %O`, el);
        el.classList.add('hide');
        el.addEventListener('transitionend', addHiddenClass);
    }

    show(el) {
        console.log(`Showing: %O`, el);
        this.hide(this.currentEl);
        this.resizeToFit(el);
        el.classList.remove('hidden');
    }

    resizeToFit(el) {
        console.log(`Resizing: %O}`, el);
        el.classList.remove('hidden');
        let rect = el.getBoundingClientRect();
        let newWidth = rect.width + 'px';
        let newHeight = rect.height + 'px';
        el.classList.add('hidden');

        console.log(`width=${newWidth}`);
        console.log(`height=${newHeight}`);
        this.buttonBarEl.style.width = newWidth;
        this.buttonBarEl.style.height = newHeight;

        this.buttonBarEl.addEventListener('transitionend', function resize(e) {
            console.log(e.propertyName);
            if (e.propertyName !== 'width' && e.propertyName !== 'height') {
                return;
            }
            el.classList.remove('hidden');
            setTimeout(() => {
                el.classList.remove('hide');
            }, 10);
            e.currentTarget.removeEventListener('transitionend', resize);
        });
    }    
}


function addHiddenClass() {
    e.currentTarget.classList.add('hidden');
    e.currentTarget.removeEventListener('transitionend', addHiddenClass);
}