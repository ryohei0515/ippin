<template>
  <div class="sm:flex sm:flex-row">
    <div>
      <div class="input-label">都道府県</div>
      <div class="w-24 relative text-gray-700">
        <select :name="largeAreaName" v-model="largeAreaSelected" class="pr-8 shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline bg-white">
          <option :value="initLargeArea" v-if="initLargeArea">{{ initLargeArea }}</option>
          <option value="">-</option>
          <option v-for="areaName in largeAreas" :value="areaName" :key="areaName">
            {{ areaName }}
          </option>
        </select>
        <i class="fa fa-chevron-down absolute right-2 top-0 bottom-0 m-auto pointer-events-none" aria-hidden="true"></i>
      </div>
    </div>
    <div class="mt-2 sm:ml-6 sm:mt-0">
      <div class="input-label">エリア</div>
      <div class="w-72 relative text-gray-700">
        <select :name="middleAreaName" :value="middleAreaSelected"  class="pr-8 shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline bg-white">
          <option :value="initMiddleArea" v-if="initMiddleArea && initLargeArea == largeAreaSelected">{{ initMiddleArea }}</option>
          <option value="">-</option>
          <option v-for="areaName in middleAreas" :value="areaName" :key="areaName">
            {{ areaName }}
          </option>
        </select>
        <i class="fa fa-chevron-down absolute right-2 top-0 bottom-0 m-auto pointer-events-none" aria-hidden="true"></i>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    initLargeArea: { type: String, default: "" },
    initMiddleArea: { type: String, default: "" },
    largeAreaName: { type: String, default: "" },
    middleAreaName: { type: String, default: "" },
  },
  data() {
    return {
      result: {},
      largeAreas: [
        "北海道",
        "青森",
        "岩手",
        "宮城",
        "秋田",
        "山形",
        "福島",
        "茨城",
        "栃木",
        "群馬",
        "埼玉",
        "千葉",
        "東京",
        "神奈川",
        "新潟",
        "富山",
        "石川",
        "福井",
        "山梨",
        "長野",
        "岐阜",
        "静岡",
        "愛知",
        "三重",
        "滋賀",
        "京都",
        "大阪",
        "兵庫",
        "奈良",
        "和歌山",
        "鳥取",
        "島根",
        "岡山",
        "広島",
        "山口",
        "徳島",
        "香川",
        "愛媛",
        "高知",
        "福岡",
        "佐賀",
        "長崎",
        "熊本",
        "大分",
        "宮崎",
        "鹿児島",
        "沖縄",
      ],
      middleAreas: [],
      middleAreasGroup: {},
      largeAreaSelected: "",
      middleAreaSelected: "",
    };
  },
  async created() {
    var res = await axios.get("/api/v1/areas/");

    // large_areaのnameをキーとした連想配列を作成
    for (var i = 0; i < res.data.middle_area.length; i++) {
      var data = res.data.middle_area[i];

      if (data.large_area.name in this.middleAreasGroup) {
        this.middleAreasGroup[data.large_area.name].push(data.name);
      } else {
        this.middleAreasGroup[data.large_area.name] = [data.name];
      }
    }
    this.middleAreas = this.middleAreasGroup[this.largeAreaSelected];
  },
  mounted() {
    this.largeAreaSelected = this.initLargeArea != null ? this.initLargeArea : "";
    this.middleAreaSelected = this.initMiddleArea != null ? this.initMiddleArea : "";
  },
  watch: {
    largeAreaSelected: function(v) {
      this.middleAreas = this.middleAreasGroup[v];
    }
  }
};
</script>

<style scoped>
</style>