import nav from '../modules/nav';

const universal = () => {
  let props = {
    isEnabled: false,
    modules: {
      nav
    }
  };

  const init = () => {
    enable();
  }

  const enable = () => {
    if (props.isEnabled) return;

    for (module in props.modules) {
      // check if module is a function which means it hasn't been created
      // since modules return an object, they become objects with methods
      if (!props.modules[module].init) props.modules[module] = props.modules[module]();

      props.modules[module].init();
    }

    props.isEnabled = true;

    return;
  }

  const disable = () => {
    if (!props.isEnabled) return;

    for (module in props.modules) {
      props.modules[module].disable();
    }

    props.isEnabled = false;

    return;
  }

  return {
    init,
    enable,
    disable
  };
}

export default universal;
