import axios from 'axios';

const asyncImageHandler = () => {
  let url, inputs, initiated = false

  const sendRequest = (data, node) => {
    const csrf    = document.querySelector('meta[name=csrf-token]').content;
    const headers = { 'X-CSRF-Token': csrf };
    const hidden  = node.previousSibling
    let preview   = document.getElementById(node.dataset.previewId);
    let iconSpan

    if (preview) {
      iconSpan = hidden.previousSibling;
      iconSpan.classList.toggle('animate');
    }

    return axios({
      url,
      method: 'POST',
      responseType: 'json',
      data,
      headers
    })
    .then(response => {
      let { value, url } = response.data
      hidden.value = value

      if (preview) {
        let img   = document.createElement('img')
        img.src   = url
        img.style = 'width: 75%; margin: 0 auto;'

        preview.innerHTML = '';
        iconSpan.classList.remove('animate');
        preview.appendChild(img);
      }
    })
    .catch(response => {
    })
  }

  const asyncUpload = (e) => {
    const data = new FormData();
    const node = e.target
    const file = node.files[0]

    data.append('file', e.target.files[0])

    sendRequest(data, e.target);
  }

  const constructSrc = (data) => {
    return '/uploads/' + data.storage + '/' + data.id
  }

  const enable = () => {
    inputs = document.querySelectorAll('.js-async-image');
    inputs.forEach(input => input.addEventListener('change', asyncUpload));
  }

  const disable = () => {
    inputs.forEach(input => input.removeEventListener('change', asyncUpload));
  }

  const init = (_url) => {
    if (initiated) {
      disable();
    } else {
      url       = _url;
      initiated = true;
    }

    enable();
  }

  return { init }
}

export default asyncImageHandler();
