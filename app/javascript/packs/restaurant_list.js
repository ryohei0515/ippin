import Vue from 'vue/dist/vue.esm.js'
import App from '../restaurant-list.vue'
Vue.config.devtools = true;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#content',
    render: h => h(App)
  })
})
