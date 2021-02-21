import Vue from 'vue/dist/vue.esm.js'
import App from '../select-shop.vue'

document.addEventListener('DOMContentLoaded', () => {
    const searchModal = new Vue({
      el: '#select-shop-modal',
      render: h => h(App, { props: { initShopId: document.getElementById('shop-label').getAttribute('data-shop') } })
  })
})
