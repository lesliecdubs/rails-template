/**
 * Creates a JS controller with our typical rails pattern. All arguments are optional
 * but it would be useless if there weren't any. Options will eventually
 * include potential callbacks to execute at different points of the
 * controller lifecycle
 *
 * @param  {Object} modules           Collection of modules (optional)
 * @param  {Object} windowLoadModules Collection of modules to execute on windowLoad (optional)
 * @param  {Object} options           Various callbacks to execute throughout lifecycle
 * @return {Object}                   Publicly exposed functions
 */
const controller = (
  modules = {},
  windowLoadModules = {},
  options = {}
) => {
  let props = {
    isEnabled: false,
    isWindowLoadEnabled: false,
    modules: modules,
    windowLoadModules: windowLoadModules
  };

  // Verify options are passed correctly and combine with default options
  options = Object.assign({}, {
    onCreation: () => {},
    onInit: () => {},
    onWindowLoadInit: () => {},
    onEnable: () => {},
    onDisable: () => {}
  }, options);

  options.onCreation();

  const mergeModules = () => { return Object.assign({}, props.modules, props.windowLoadModules); }

  const initModuleSet = (moduleGroup) => {
    for (let module in props[moduleGroup]) {
      if (props[moduleGroup].hasOwnProperty(module)) {
        // check if module is a function which means it hasn't been created
        // since modules return an object, they become objects with methods
        if (!props[moduleGroup][module].init) props[moduleGroup][module] = props[moduleGroup][module]();
        props[moduleGroup][module].init();
      }
    }

    return;
  }

  const init = () => {
    options.onInit();
    enable();
    return;
  }

  const initWindowLoad = () => {
    initModuleSet('windowLoadModules');
    options.onWindowLoadInit();
    props.isWindowLoadEnabled = true;
    return;
  }

  const enable = () => {
    if (props.isEnabled) return;

    initModuleSet('modules');

    options.onEnable();

    props.isEnabled = true;

    return;
  }

  const disable = () => {
    if (!props.isEnabled) return;

    for (let module in props.modules) {
      if (props.modules.hasOwnProperty(module)) {
        props.modules[module].disable();
      }
    }

    if (props.isWindowLoadEnabled) {
      for (let module in props.windowLoadModules) {
        if (props.windowLoadModules.hasOwnProperty(module)) {
          props.windowLoadModules[module].disable();
        }
      }
    }

    options.onDisable();

    props.isEnabled = false;
    props.isWindowLoadEnabled = false;

    return;
  }

  return {
    init,
    initWindowLoad,
    enable,
    disable,
    modules: mergeModules
  };
}

/**
 * Limits the rate of executions for a recurring event.
 * Returns a function, that, when invoked, will only be
 * triggered at most once during a given window of time.
 * Normally, the throttled function will run as much as
 * it can, without ever going more than once per wait
 * duration; but if you’d like to disable the execution
 * on the leading edge, pass {leading: false}. To disable
 * execution on the trailing edge, ditto.
 * Source: http://underscorejs.org/docs/underscore.html
 *
 * @param  {Function} func  Function to execute
 * @param  {Number} wait    Time between executions
 * @param  {Object} options Options to pass to the throttle function
 * @return {Function}       Throttled function
 */
const throttle = (func, wait, options) => {
  let context, args, result;
  let timeout = null;
  let previous = 0;
  if (!options) options = {};
  const later = function() {
    previous = options.leading === false ? 0 : _now();
    timeout = null;
    result = func.apply(context, args);
    if (!timeout) context = args = null;
  }
  return function() {
    let now = _now();
    if (!previous && options.leading === false) previous = now;
    let remaining = wait - (now - previous);
    context = this;
    args = arguments;
    if (remaining <= 0 || remaining > wait) {
      if (timeout) {
        clearTimeout(timeout);
        timeout = null;
      }
      previous = now;
      result = func.apply(context, args);
      if (!timeout) context = args = null;
    } else if (!timeout && options.trailing !== false) {
      timeout = setTimeout(later, remaining);
    }
    return result;
  }
}

/**
 * Returns a function, that, as long as it continues to be invoked, will not
 * be triggered.
 * Source: https://davidwalsh.name/javascript-debounce-function (also Underscore.js)
 *
 * @param  {Function} func Function to execute once from a repeated event
 * @param  {Number} wait Triggers the function after N milliseconds
 * @param  {Boolean} immmediate If true, triggers the function on the leading edge instead of the trailing
 * @return {Function}
 */
const debounce = (func, wait, immediate) => {
  let timeout;
  return function() {
    let context = this, args = arguments;
    const later = () => {
      timeout = null;
      if (!immediate) func.apply(context, args);
    }
    let callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  }
}

// File exports
export {
  controller,
  throttle,
  debounce
};
