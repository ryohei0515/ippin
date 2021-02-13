<template>
  <div class="root">
    <Search class="search" @loadStart="onLoadStart" @loadComplete="onLoadComplete"/>
    <Result :results="results" :loadProgress="loadProgress"/>
    <div class="mx-auto w-32 my-5">
      <a class="mx-auto" href="http://webservice.recruit.co.jp/"><img src="http://webservice.recruit.co.jp/banner/hotpepper-s.gif" alt="ホットペッパー Webサービス" width="135" height="17" border="0" title="ホットペッパー Webサービス"></a>
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
