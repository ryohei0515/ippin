import Vue from 'vue/dist/vue.esm.js'
import App from '../restaurant-list.vue'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#content',
    render: h => h(App)
  })
})
