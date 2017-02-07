import 'babel-polyfill';
import * as controllers from './controllers/controllers';

const app = () => {
  let props = {
    currentPage: '',
    universalController: null,
    currentController: null
  };

  const runPageJs = () => {
    const { currentPage } = props;
    if (controllers[currentPage]) {
      props.currentController = !controllers[currentPage].init ? controllers[currentPage]() : controllers[currentPage];
      props.currentController.init();
    }

    return;
  }

  const runUniversalJs = () => {
    if (!props.universalController) {
      props.universalController = controllers.universal();
    }

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
    init
  };
}

export default app;
