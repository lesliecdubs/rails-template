// ==================================================================================================
//
// Example Boiler
// Example boiler description
//
// ==================================================================================================

const exampleBoiler = () => {
  let props = {
    isEnabled: false
  };

  // Cache dom element selectors
  const createChildren = () => {
    return;
  }

  const init = () => {
    createChildren();
    enable();
    return;
  }

  const enable = () => {
    if (props.isEnabled) return;

    // Add your event handlers here

    props.isEnabled = true;

    return;
  }

  const disable = () => {
    if (!props.isEnabled) return;

    // Remove your event handlers here

    props.isEnabled = false;

    return;
  }

  return {
    init,
    enable,
    disable
  };
}

export default exampleBoiler;
