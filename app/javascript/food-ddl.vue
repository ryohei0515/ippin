<template>
<div class="w-full relative">
  <div lass="relative" @click="openAndCloseDdl">
    <input type="text" id="display-text-box" :value="selectText" readonly class="border w-full pr-8">
    <i class="fa fa-chevron-down absolute right-2 top-0 bottom-0 m-auto" aria-hidden="true"></i>
  </div>
  <div v-show="listShow" class="p-2 absolute z-20 border bg-white shadow-lg w-full">
    <input type="text" ref="filterTextBox" id="filter-text-box" class="border w-full" v-model="filterText" placeholder="複数条件入力可能です（例:北京　餃子）">
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
  data() {
    return {
      foods: [],
      listShow: false,
      filterText: "",
      selectText: ""
    };
  },
  async created() {
    this.foods = await axios.get('/api/v1/foods/');
  },
  methods: {
    openAndCloseDdl() {
      this.listShow = !this.listShow;
    },
    selectItem(item) {
      this.selectText = this.displayText(item);
      this.listShow = false;
    },
    displayText(item) {
      var txt = item.category + " | " + item.name
      if (item.name_kana) txt += " | " + item.name_kana
      return txt
    },

  },
  computed: {
    filteredItem() {
      if (!this.filterText) return this.foods.data
      var txt = "^(?=.*" + this.filterText + ")"
      // スペース区切りの検索条件は複数条件と扱う
      txt = txt.replace(/　/g, " ").replace(/ /g, ")(?=.*");
      var pattern = new RegExp(txt, "i")

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