// -------------------------------------------------------------------------
// Redactor configurations
// -------------------------------------------------------------------------

const redactor = () => {

  // This reloads redactor for turbolinks
  const reloadRedactor = (node) => {
    let parent     = node.parentNode;
    let nextParent = parent.parentNode;

    nextParent.removeChild(parent);
    nextParent.appendChild(node);
  }

  const init = (options) => {
    let formatting    = ['p', 'blockquote', 'h3'];
    let buttons       = ['format', 'bold', 'italic', 'lists', 'link','inlineImage']
    let imageUpload   = '/images/cache/upload'
    let minHeight     = 150;
    let placeholder   = 'Add content here...';
    let plugins       = ['inlineImage', 'video'];
    let limiter       = 500;
    let linebreaks    = null;
    let paragraphize  = null;
    let toolbarFixed  = false;

    const redactorField = document.querySelectorAll('.js-redactor');

    redactorField.forEach( node => {
      node.dataset.initiated ? reloadRedactor(node) : node.dataset.initiated = true;

      if (node.dataset.redactorButtons) buttons           = node.dataset.redactorButtons.split(', ');
      if (node.dataset.redactorFormatting) formatting     = node.dataset.redactorFormatting.split(', ');
      if (node.dataset.redactorHeight) minHeight          = node.dataset.redactorHeight;
      if (node.dataset.redactorPlaceholder) placeholder   = node.dataset.redactorPlaceholder;
      if (node.dataset.redactorParagraphize) paragraphize = node.dataset.redactorParagraphize;
      if (node.dataset.redactorLinebreaks) linebreaks     = node.dataset.redactorLinebreaks;
      if (node.dataset.redactorPlugins) plugins           = node.dataset.redactorPlugins.split(', ');
      if (node.dataset.redactorLimiter) limiter           = node.dataset.redactorLimiter;
      if (node.dataset.redactorToolbarFixed) toolbarFixed = node.dataset.redactorToolbarFixed;

      $(node).redactor({
        placeholder,
        imageUpload,
        buttons,
        formatting,
        minHeight,
        linebreaks,
        paragraphize,
        limiter,
        toolbarFixed,
        plugins,
        ...options
      });
    });
  }

  return { init }
}

export default redactor();
