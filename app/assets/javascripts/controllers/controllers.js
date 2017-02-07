// Import all modules
// _______________________________________________
import breakpoint     from '../utilities/breakpoint';
import example        from '../modules/example';

// Controller Generation
import { controller } from '../utilities/savnac';

// Create Controllers
// _______________________________________________
const universal = controller({
  breakpoint
});

const pages_homepage = controller({
  example
});

// Export Controllers
// _______________________________________________
export {
  universal,
  pages_homepage
};
