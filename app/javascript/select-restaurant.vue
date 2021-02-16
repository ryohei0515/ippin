<template>
  <div class="overlay z-10 fixed top-0 left-0 w-full h-full">
    <div class="content z-20 bg-white max-h-11/12 w-11/12 rounded">
      <Search class="search" @loadStart="onLoadStart" @loadComplete="onLoadComplete"/>
      <Result class="result overflow-y-scroll" :results="results" :loadProgress="loadProgress" :scrollable="true"/>
      <div class="mx-auto w-32 my-2">
        <a class="mx-auto" href="https://webservice.recruit.co.jp/"><img src="https://webservice.recruit.co.jp/banner/hotpepper-s.gif" alt="ホットペッパー Webサービス" width="135" height="17" border="0" title="ホットペッパー Webサービス"></a>
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