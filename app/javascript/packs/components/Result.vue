<template>
  <div class="container mx-auto">
    <div class="my-2 mx-auto w-11/12 rounded bg-yellow-100 p-2 text-center" v-if="results.results_available > 100">
      件数が多いため、上位100件のみ表示しています。
    </div>
    <div class="my-2 mx-auto w-11/12 rounded bg-red-200 p-2 text-center" v-if="results.results_available == 0">
      合致するお店が見つかりません。<br>別のキーワードで検索してください。
    </div>
    <ul class="list">
      <li class="w-11/12 mx-auto bg-gray-100 my-4 p-4 sm:flex sm:justify-start" v-for="shop of results.shop" :key="shop.id">
          <div class="mx-auto w-11/12 sm:mx-4 sm:my-auto sm:w-2/12">
            <img class="w-full h-auto" :src="shop.photo.mobile.l" :alt=shop.name>
          </div>
          <div class="mt-2 mx-auto sm:mx-0 sm:w-10/12 sm:flex sm:justify-between">
            <div>
              <div class="font-bold text-lg">{{ shop.name }}</div>
              <div class="">{{ shop.genre.name }} </div>
              <div class="mt-2">住所：{{ shop.address }}</div>
              <div class="">最寄り駅：{{ shop.station_name }}</div>
              <div class="">{{ shop.genre.catch }} </div>
            </div>
            <div class="flex flex-col items-end">
              <input class="select-button text-center rounded py-2 bg-yellow-200 hover:bg-yellow-400 w-full mx-auto sm:w-20 sm:mt-auto" type="button" value="選択" @click="selectShop(shop)">
            </div>
          </div>

      </li>
    </ul>
    <Loading class="loading" v-show="loadProgress"/>
  </div>
</template>

<script>
import Loading from "./Loading";

export default {
  props: ["results", "loadProgress"],
  components: {
    Loading,
  },
  methods: {
    selectShop (shop) {
      this.$emit("selectShop", { shop: shop });
    }
  },
};
</script>

<style scoped>
.loading {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1;
  background:rgba(200,200,200,0.7);
}
</style>
