import Vue from 'vue/dist/vue.esm.js'
import FoodDdl from '../food-ddl.vue'
import AreaDdl from '../area-ddl.vue'

document.addEventListener('DOMContentLoaded', () => {
  const foodDdl = new Vue({
    el: '#food-ddl',
    render: h => h(FoodDdl, {
      props: {
        initFoodId: document.getElementById('food-id-label').getAttribute('data-food-id'),
        name: "food_id"
      }
    })
  })

  const areaDdl = new Vue({
    el: '#area-ddl',
    render: h => h(AreaDdl, {
      props: {
        initLargeArea: document.getElementById('area-label').getAttribute('data-large-area'),
        initMiddleArea: document.getElementById('area-label').getAttribute('data-middle-area'),
        largeAreaName: "large_area",
        middleAreaName: "middle_area"
      }
    })
  })
})
