//  ==========================================================================
//
//  Set Up JS App & Router
//
//  ==========================================================================
import * as controllers from './controllers/controllers';

const Dataminr = () => {
  const mobileRE = /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/i;

  let props = {
    // currentPage is the string from the body data attr that corresponds with a controller
    currentPage: '',
    // universalController is the resulting object of the universal controller. stored to be able to disable
    // it as navigation to a new page occurs
    universalController: controllers.universal,
    // currentController is the resulting object of the page controller. stored to be able to disable
    // it as navigation to a new page occurs
    currentController: null,
    // isMobileDevice is a boolean for determining if user is on a mobile device
    isMobileDevice: checkMobileDevice(),
    isMobile: false,
    currentBreakpoint: ''
  };

  checkBreakpoint();
  checkMobileBp();

  function checkBreakpoint() {
    props.currentBreakpoint = window.getComputedStyle(document.body, ':before').getPropertyValue('content').replace(/\"/g, '');
    return props.currentBreakpoint;
  }

  function checkMobileBp() {
    props.isMobile = props.currentBreakpoint === 'sm' || props.currentBreakpoint === 'md';
    return props.isMobile;
  }

  function checkMobileDevice() { return mobileRE.test(navigator.userAgent); }

  const getUniversalModules = () => { return props.universalController.modules; }
  const getPageModules = () => { return props.currentController ? props.currentController.modules : null; }

  const runPageJs = () => {
    const { currentPage } = props;
    if (controllers[currentPage]) {
      props.currentController = !controllers[currentPage].init ? controllers[currentPage]() : controllers[currentPage];
      props.currentController.init();
    }

    return;
  }

  const runUniversalJs = () => {
    props.universalController.disable();
    props.universalController.init();

    return;
  }

  const init = () => {
    props.currentPage = document.body.dataset.jsRouter;

    if (props.currentController) {
      props.currentController.disable();
      props.currentController = null;
    }

    runPageJs();
    runUniversalJs();

    return;
  }

  return {
    init,
    checkBreakpoint,
    checkMobileBp,
    getUniversalModules,
    getPageModules,
    currentBreakpoint: props.currentBreakpoint,
    isMobile: props.isMobile,
    isMobileDevice: props.isMobileDevice,
  };
}

export default Dataminr;
