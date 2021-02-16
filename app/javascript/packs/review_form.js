import Vue from 'vue/dist/vue.esm.js'
import App from '../select-restaurant.vue'

document.getElementById('select_restaurant_modal_link').addEventListener('click', () => {
  const app = new Vue({
    el: '#select-restaurant-modal',
    render: h => h(App)
  })
})
// document.addEventListener('turbolinks:load', () => {
//   document.getElementById('select_restaurant_modal_link').addEventListener('click', () => {
//     const searchModal = new Vue({
//       el: '#select-restaurant-modal',
//       render: h => h(App)
//     })
//   })
// })
// new Vue({
//   el: '#search-restaurant-modal',
//   data: {
//     showContent: false
//   },
//   methods: {
//     openModal: function () {
//       this.showContent = true
//     },
//     closeModal: function () {
//       this.showContent = false
//     }
//   }
// })