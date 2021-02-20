import Vue from 'vue/dist/vue.esm.js'
import App from '../select-restaurant.vue'

document.addEventListener('DOMContentLoaded', () => {
    const searchModal = new Vue({
      el: '#select-restaurant-modal',
      render: h => h(App, { props: { initRestaurantId: document.getElementById('restaurant-label').getAttribute('data-restaurant') } })
  })
})
