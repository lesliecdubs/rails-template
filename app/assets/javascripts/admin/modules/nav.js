// ==================================================================================================
//
// Nav
// Any custom nav functionality. Currently for demo purposes
//
// ==================================================================================================

const nav = () => {
  let props = {
    isEnabled: false
  };

  const init = () => {
    enable();
    return;
  }

  const enable = () => {
    if (props.isEnabled) return;

    console.log('enabling nav')

    props.isEnabled = true;
    return;
  }

  const disable = () => {
    if (!props.isEnabled) return;

    props.isEnabled = false;
    return;
  }

  return {
    init,
    enable,
    disable
  };
}
