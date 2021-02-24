<template>
<div class="w-80 relative">
  <input type="text" id="display-text-box" readonly @click="openAndCloseDdl" class="border w-full">
  <div v-if="listShow" class="p-2 absolute z-20 border bg-white shadow-lg w-full">
    <input type="text" ref="filterTextBox" id="filter-text-box" class="border w-full" v-model="filterText">
    <ul class="overflow-y-scroll" style="max-height: 40vh;">
      <li class="hover:bg-blue-300" v-for="food of filteredItem" :key="food.id">{{ food.category }} | {{ food.name }} | {{ food.name_kana }}</li>
    </ul>
  </div>
  <!-- <div class="my-5">{{ foods }}</div> -->
</div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      foods: [],
      listShow: false,
      filterText: ""
    };
  },
  async created() {
    this.foods = await axios.get('/api/v1/foods/');
  },
  methods: {
    openAndCloseDdl() {
      this.listShow = !this.listShow;
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
    },
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