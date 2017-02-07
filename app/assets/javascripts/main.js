//  ==========================================================================
//
//  Set Up JS App & Router
//
//  ==========================================================================
import 'babel-polyfill';
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
    // currentBreakpoint is a string value representing the current breakpoint that
    // is synced with the CSS breakpoints
    currentBreakpoint: checkBreakpoint()
  };

  function checkBreakpoint() {
    return window.getComputedStyle(document.body, ':before').getPropertyValue('content').replace(/\"/g, '');
  }

  function checkMobileDevice() {
    return mobileRE.test(navigator.userAgent);
  }

  const getUniversalModules = () => { return props.universalController.modules(); }
  const getPageModules = () => { return props.currentController ? props.currentController.modules() : null; }

  const onImagesLoad = () => {
    if (props.currentController) props.currentController.initWindowLoad();
    props.universalController.initWindowLoad();
    return;
  }

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
    getUniversalModules,
    getPageModules,
    currentBreakpoint: props.currentBreakpoint,
    isMobileDevice: props.isMobileDevice
  };
}

export default Dataminr;
