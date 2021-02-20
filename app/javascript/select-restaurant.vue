<template>
<div>
  <div class="float flex flex-row">
    <label class="block text-gray-700 text-sm mb-2 mx-2" :value="restaurantName" >{{ restaurantName }}</label>
    <a class="font-bold text-blue-500" id="select_restaurant_modal_link" href="#" @click.self="modalOpen">レストランを選択</a>
    <input type="hidden" name="review[restaurant]" id="review_restaurant" :value="restaurantId">
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
import axios from "axios";

export default {
  props: ['initRestaurantId'],
  data() {
    return {
      results: [],
      loadProgress: false,
      modalShow: false,
      restaurantName: "",
      restaurantId: ""
    };
  },
  async created() {
    this.restaurantId = this.initRestaurantId;
    if (this.restaurantId != null) {
      var r = await axios.get('/api/v1/restaurants/' + this.restaurantId);
      this.restaurantName = r.data[0].name
    } else {
      this.restaurantName = "未選択"
    }
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
      this.restaurantId = restaurant.id;
      this.restaurantName = restaurant.name;
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