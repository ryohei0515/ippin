import Vue from 'vue/dist/vue.esm.js'
import FoodDdl from '../food-ddl.vue'
import AreaDdl from '../area-ddl.vue'

document.addEventListener('DOMContentLoaded', () => {
  const foodDdl = new Vue({
    el: '#food-ddl',
    render: h => h(FoodDdl, {
      props: {
        initFoodId: document.getElementById('food-ddl').getAttribute('data-food-id'),
        name: "food_id"
      }
    })
  })

  const areaDdl = new Vue({
    el: '#area-ddl',
    render: h => h(AreaDdl, {
      props: {
        initLargeArea: document.getElementById('area-ddl').getAttribute('data-large-area'),
        initMiddleArea: document.getElementById('area-ddl').getAttribute('data-middle-area'),
        largeAreaName: "large_area",
        middleAreaName: "middle_area"
      }
    })
  })

  document.getElementById('search-button').addEventListener('click', function (e) {
    var i = document.getElementsByName("food_id")[0].value
    if (i == "") {
      let el = document.getElementById('food-ddl-disp');
      el.classList.remove("border");
      el.classList.remove("bg-white");
      el.classList.add("error-input");
      Swal.fire({
        html: '料理を選択してください',
        icon: 'error',
        confirmButtonColor: '#60a5fa'
      });
      e.preventDefault();
    }
  })
})
