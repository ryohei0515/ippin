import Vue from 'vue/dist/vue.esm.js'
import App from '../select-restaurant.vue'


// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#select-restaurant-modal',
//     // data() {
//     //   return {
//     //     selectRestaurantModalShow: false
//     //   };
//     // },
//     render: h => h(App)
//   })
// })

// export default {
// //   // data() {
// //   //   return {
// //   //     results: [],
// //   //     loadProgress: false,
// //   //     selectRestaurantModalShow: true
// //   //   };
// //   // },
// //   // methods: {
// //   //   onLoadStart() {
// //   //     this.loadProgress = true;
// //   //   },
// //   //   onLoadComplete({ results }) {
// //   //     this.results = results;
// //   //     this.loadProgress = false;
// //   //   },
// //   //   selectRestaurantModalOpen() {
// //   //     this.selectRestaurantModalShow = true
// //   //   },
// //   //   selectRestaurantModalClose() {
// //   //     this.selectRestaurantModalShow = false
// //   //   },
// //   // },
//   components: {
//     App,
//   },
//   methods: {
//     testtest() {
//       alert("testtest")
//       this.$refs.App.selectRestaurantModalOpen()
//     }
//   },
// };

// export default {
//   data() {
//     return {
//       term: ""
//     }
//   },
//   methods: {
//     async exe() {
//       if (!this.term) {
//         alert('検索条件を入力してください');
//         return
//       }
//       this.term = this.term.replace(/　/g, " ");
//       this.$emit("loadStart");
//     },
//   },
// };

document.addEventListener('turbolinks:load', () => {
  // document.getElementById('select_restaurant_modal_link').addEventListener('click', () => {
    const searchModal = new Vue({
      el: '#select-restaurant-modal',
      render: h => h(App)
    // })
  })
})
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