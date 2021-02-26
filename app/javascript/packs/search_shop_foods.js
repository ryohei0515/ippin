import Vue from 'vue/dist/vue.esm.js'
import Ddl from '../food-ddl.vue'

document.addEventListener('DOMContentLoaded', () => {
  const foodDdl = new Vue({
    el: '#food-ddl',
    render: h => h(Ddl, { props: { initFoodId: "", name: "food_id" } })
  })
})
