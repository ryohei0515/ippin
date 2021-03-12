
<template>
  <div>
    <div class="container mx-auto my-4 px-4 flex justify-start">
      <input id="shop-textbox" class="shadow appearance-none border rounded py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline w-full" :class="inputClass" type="text" v-model="term" @keyup.enter="exe" placeholder="店名、住所、駅名、お店ジャンル...">
      <input class="text-center rounded py-2 bg-blue-400 hover:bg-blue-600 text-white w-20 ml-2" type="button" value="検索" @click="exe">
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      term: "",
      inputClass: ""
    }
  },
  methods: {
    async exe() {
      if(!this.term) {
        this.inputClass = "error-input"
        Swal.fire({
          html: 'キーワードを入力してください',
          icon: 'error',
          confirmButtonColor: '#60a5fa'
        });
        return
      }
      this.inputClass = ""
      this.term = this.term.replace(/　/g," ");
      this.$emit("loadStart");
      const { data } = await axios.get('/api/v1/shops.json', {
                        params: {
                          term: this.term
                        }
                      });
      this.$emit("loadComplete", { results: data })
    },
  },
};
</script>

<style scoped>

</style>
