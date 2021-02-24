import Vue from 'vue/dist/vue.esm.js'
import Modal from '../select-shop.vue'
import Ddl from '../food-ddl.vue'

document.addEventListener('DOMContentLoaded', () => {
  const searchModal = new Vue({
    el: '#select-shop-modal',
    render: h => h(Modal, { props: { initShopId: document.getElementById('shop-label').getAttribute('data-shop') } })
  })

  const foodDdl = new Vue({
    el: '#food-ddl',
    render: h => h(Ddl, { props: { initFoodId: document.getElementById('food-id-label').getAttribute('data-food-id') } })
  })
})
