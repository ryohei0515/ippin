<template>
<div id="food-ddl" class="w-full relative">
  <div class="relative" @click="openAndCloseDdl">
    <input type="hidden" :name="name" :value="foodId">
    <div class="pr-8 shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
      <label :value="selectText" >{{ selectText }}</label>
      <i class="fa fa-chevron-down absolute right-2 top-0 bottom-0 m-auto" aria-hidden="true"></i>
    </div>
  </div>
  <div v-if="listShow" class="p-2 absolute z-20 border bg-white shadow-lg w-full">
    <input type="text" ref="filterTextBox" id="filter-text-box" class="mb-2 border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" v-model="filterText" placeholder="複数条件入力可能です（例:北京　餃子）">
    <ul class="overflow-y-scroll" style="max-height: 40vh;">
      <li class="bg-yellow-100" v-show="filteredItem.length == 0">ヒットする料理がありません。再入力してください。</li>
      <li class="hover:bg-blue-300" v-for="food of filteredItem" :key="food.id" @click="selectItem(food)">{{ displayText(food) }}</li>
    </ul>
  </div>
</div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    initFoodId: { type: String, default: "" },
    name: { type: String, default: "" }
  },
  data() {
    return {
      foods: [],
      listShow: false,
      filterText: "",
      selectText: "",
      foodId: "",
    };
  },
  async created() {
    this.foodId = this.initFoodId
    this.foods = await axios.get('/api/v1/foods/');
    if (this.foodId) {
      var item = this.foods.data.find(food => food.id == this.foodId);
      this.selectText = this.displayText(item);
    } else {
      this.selectText = "未選択"
    }
  },
  mounted() {
    document.addEventListener('click', (e) => {
      if(!e.target.closest('#food-ddl')) {
        this.closeDdl();
      }
    })
  },
  methods: {
    openAndCloseDdl() {
      this.listShow = !this.listShow;
    },
    closeDdl() {
      this.listShow = false;
    },
    selectItem(item) {
      this.selectText = this.displayText(item);
      this.foodId = item.id
      this.closeDdl();
      this.filterText = "";
    },
    displayText(item) {
      var txt = item.category + " | " + item.name;
      if (item.name_kana) txt += " | " + item.name_kana;
      return txt;
    },

  },
  computed: {
    filteredItem() {
      if (!this.filterText) return this.foods.data
      var txt = "^(?=.*" + this.filterText + ")";
      // スペース区切りの検索条件は複数条件と扱う
      txt = txt.replace(/　/g, " ").replace(/ /g, ")(?=.*");
      var pattern = new RegExp(txt, "i");

      return this.foods.data.filter(function(item){
        return pattern.test(item.category + item.name + item.name_kana);
      })
    }
  },
  watch: {
    listShow(val) {
      if(val) {
        this.$nextTick(() => {
          this.$refs.filterTextBox.focus();
        });
      }
    }
  },
};
</script>

<style scoped>

</style>