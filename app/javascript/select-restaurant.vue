<template>
<div>
  <div>
    <input class="text-center rounded py-2 bg-blue-600 hover:bg-blue-600 text-white w-20 ml-2" type="button" value="new選択する" @click.self="modalOpen">
    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline bg-blue-200" type="text" name="review[restaurant]" id="review_restaurant" v-model="restaurant_name" readonly>
  </div>
  <div class="overlay z-10 fixed top-0 left-0 w-full h-full" @click.self="modalClose" v-show="modalShow" @test="modalOpen">
    <div class="content z-20 bg-white max-h-11/12 w-11/12 lg:container rounded">
      <Search class="search" @loadStart="onLoadStart" @loadComplete="onLoadComplete"/>
      <Result class="result overflow-y-scroll" :results="results" :loadProgress="loadProgress" @selectRestaurant="selectItem"/>
      <div class="mx-auto w-32 my-2">
        <a class="mx-auto" href="https://webservice.recruit.co.jp/"><img src="https://webservice.recruit.co.jp/banner/hotpepper-s.gif" alt="ホットペッパー Webサービス" width="135" height="17" border="0" title="ホットペッパー Webサービス"></a>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import Search from "./packs/components/Search";
import Result from "./packs/components/Result";

export default {
  data() {
    return {
      results: [],
      loadProgress: false,
      modalShow: false,
      restaurant_name: "",
      restaurant_id: ""
    };
  },
  methods: {
    onLoadStart() {
      this.loadProgress = true;
    },
    onLoadComplete({ results }) {
      this.results = results;
      this.loadProgress = false;
    },
    modalOpen() {
      this.modalShow = true;
    },
    modalClose() {
      this.modalShow = false;
    },
    selectItem({ restaurant }) {
      this.restaurant_id = restaurant.id;
      this.restaurant_name = restaurant.name;
      this.modalShow = false;
    },
  },
  components: {
    Search,
    Result,
  },
};
</script>

<style scoped>
.overlay{
  background-color:rgba(0,0,0,0.5);
}
.content{
  position: absolute;
  top: 50%;
  left: 50%; 
  transform: translateY(-50%) translateX(-50%);
  -webkit-transform: translateY(-50%) translateX(-50%);
}

.result{
  max-height: 80vh;
}
</style>