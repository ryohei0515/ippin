
<template>
  <div>
    <div class="container mx-auto my-4 px-4 flex justify-start">
      <input class="shadow appearance-none border rounded py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline w-full" type="text" v-model="term" @keyup.enter="exe" placeholder="店名、住所、駅名、お店ジャンル...">
      <input class="text-center rounded py-2 bg-blue-400 hover:bg-blue-600 text-white w-20 ml-2" type="submit" value="検索" @click="exe">
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      term: ""
    }
  },
  methods: {
    async exe() {
      if(!this.term) {
        alert('検索条件を入力してください');
        return
      }
      this.term = this.term.replace(/　/g," ");
      this.$emit("loadStart");
      const { data } = await axios.get('/api/v1/restaurants.json', {
                        params: {
                          term: this.term
                        }
                      });
      this.$emit("loadComplete", { results: data.results })
    },
  },
};
</script>

<style scoped>
/* .container {
  display: flex;
  justify-content: center;
  height: 70px;
  padding: 20px;
  background-color: #35495e;
  box-sizing: border-box;
}


.text {
  width: 50%;
  max-width: 300px;
  padding: .5em;
  border: none;
}


.submit {
  padding: .5em 2em;
  margin-left: 10px;
  color: #fff;
  background-color: #42b883;
  border: none;
  border-radius: 20px;
} */
</style>
