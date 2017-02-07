// ==================================================================================================
//
// Breakpoint Utitlity
//
// ==================================================================================================
import { universal } from '../controllers/controllers';
import { throttle }  from './savnac';

const breakpoint = () => {
  let props = {
    universalMods: window.Dataminr.getUniversalModules(),
    pageMods: null,
    allModules: null,
    isEnabled: false,
    currentBreakpoint: window.Dataminr.checkBreakpoint()
  };

  const createChildren = () => {
    props.pageMods = window.Dataminr.getPageModules();
    props.allModules = Object.assign({}, props.pageMods, props.universalMods);

    return;
  }

  const runResponsive = () => {
    for (let module in props.allModules) {
      let mod = props.allModules[module];
      if (mod.responsiveCallbacks && mod.responsiveCallbacks[window.Dataminr.currentBreakpoint]) {
        mod.responsiveCallbacks[window.Dataminr.currentBreakpoint]();
      }
    }

    return;
  }

  // ------------------------------------------------
  // On resize, set new breakpoint
  // ------------------------------------------------
  const onResize = (e) => {
    const newBreakpoint = window.Dataminr.checkBreakpoint();

    if (newBreakpoint !== window.Dataminr.currentBreakpoint) {
      window.Dataminr.currentBreakpoint = newBreakpoint;
      window.Dataminr.isMobile = window.Dataminr.checkMobileBp();
      runResponsive();
    }

    return;
  }

  const enable = () => {
    if (props.isEnabled) return;
    props.resizeHandler = throttle(onResize, 300);

    window.addEventListener('resize', props.resizeHandler);
    return;
  }

  const disable = () => {
    if (!props.isEnabled) return;

    window.removeEventListener('resize', props.resizeHandler);
    return;
  }

  const init = () => {
    createChildren();
    runResponsive();
    enable();
    return;
  }

  return {
    init,
    enable,
    disable
  };
}

export default breakpoint;
