<template>
<div>
</div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      foods: [],
    };
  },
  async created() {
    this.foods = await axios.get('/api/v1/foods/');
  }
};
</script>

<style scoped>

</style>