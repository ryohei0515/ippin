// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';


const sweetAlertConfirm = (element) => {
  const message = element.target.getAttribute('data-confirm-swal')
  Swal.fire({
    title: '確認',
    html: message || '実行してよろしいですか？',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: '実行',
    cancelButtonText: 'キャンセル',
  }).then(function (result) {
    if (result.value) {
      element.target.removeAttribute('data-confirm-swal')
      element.target.click()
    }
  });
  Rails.stopEverything(element);
}
Rails.delegate(document, 'a[data-confirm-swal]', 'click', sweetAlertConfirm)

Rails.start();

require("@rails/activestorage").start()
require("channels")
import '../css/tailwindcss.css';
import '@fortawesome/fontawesome-free/js/all';
window.$ = window.jQuery = require('jquery');
require('packs/raty')
import Swal from 'sweetalert2/dist/sweetalert2.js'
import 'sweetalert2/src/sweetalert2.scss'
window.Swal = Swal;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
