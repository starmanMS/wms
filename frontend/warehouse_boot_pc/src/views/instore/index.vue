<template>
  <!-- 入库列表-->
  <div>
    <el-form inline class="searchForm">
      <el-form-item>
        <el-select v-model="params.storeId" style="width: 120px;" clearable>
          <el-option v-for="store of storeList" :label="store.storeName" :value="store.storeId" :key="store.storeId"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-input v-model="params.productName" placeholder="商品名称" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item label="开始时间:">
        <el-input type="date" v-model="params.startTime" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item label="结束时间:">
        <el-input type="date" v-model="params.endTime" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getInstorePageList">
          <el-icon>
            <svg t="1646977561352" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3057" width="200" height="200"><path d="M986.304 871.424L747.328 630.4c-2.816-2.752-5.888-4.928-8.768-7.232 40.32-62.464 63.936-136.832 63.936-216.96 0-220.16-176.96-398.592-395.392-398.592C188.8 7.616 11.712 186.048 11.712 406.208s177.088 398.592 395.392 398.592a391.232 391.232 0 0 0 215.36-64.576c2.24 3.072 4.352 6.08 7.04 8.832l239.04 241.024a82.688 82.688 0 0 0 117.76 0 84.48 84.48 0 0 0 0-118.656m-579.2-192.512c-149.12 0-270.528-122.368-270.528-272.704 0-150.4 121.344-272.768 270.528-272.768 149.12 0 270.528 122.432 270.528 272.768 0 150.4-121.408 272.704-270.528 272.704" p-id="3058"></path></svg>
          </el-icon>
          &nbsp;查&nbsp;&nbsp;询
        </el-button>
      </el-form-item>
    </el-form>
    <div>
      <!-- 导出数据 -->
      <el-button type="warning" @click="export2Table">
        <el-icon>
          <svg t="1647313957290" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2289" width="200" height="200"><path d="M395.9 406H288.5c-2.8 0-5.7-0.7-8.1-2.4-18.4-13.1-18.2-34.3-6.4-46.3l217.6-220.9c11.1-11.2 29.2-11.4 40.4-0.3l0.3 0.3 217.7 221c11.1 11.3 10.9 29.4-0.4 40.4-5.3 5.2-12.5 8.2-19.9 8.2H628.1v215.7c0 7.9-6.4 14.3-14.3 14.3H410.2c-7.9 0-14.3-6.4-14.3-14.3V406zM283.3 652.4v87.5c0 7.9 6.4 14.3 14.3 14.3h428.8c7.9 0 14.3-6.4 14.3-14.3v-87.5c0-7.9 6.4-14.3 14.3-14.3h142.9c7.9 0 14.3 6.4 14.3 14.3V914c0 7.9-6.4 14.3-14.3 14.3H126.1c-7.9 0-14.3-6.4-14.3-14.3V652.4c0-7.9 6.4-14.3 14.3-14.3H269c7.9 0 14.3 6.4 14.3 14.3z" p-id="2290"></path></svg>
        </el-icon>
        &nbsp;导出数据
      </el-button>
    </div>
  </div>

  <!-- 表格 -->
  <el-table :data="instorePageList" style="width: 100%;margin-top: 10px;" table-layout="auto" size="large" border stripe>
    <el-table-column prop="insId" label="入库单ID" sortable />
    <el-table-column prop="storeName" label="仓库名称" sortable />
    <el-table-column prop="productName" label="商品名称" sortable />
    <el-table-column prop="inNum" label="入库数量" sortable />
    <el-table-column prop="inPrice" label="入库价格" sortable />
    <el-table-column label="入库状态" sortable>
      <template #default="props">
          <span :class="{red:props.row.isIn==0, green: props.row.isIn==1}">{{props.row.isIn==0?"未入库":"已入库"}}</span>
      </template>
    </el-table-column>
    <el-table-column prop="userCode" label="创建人" sortable />
    <el-table-column prop="createTime" label="创建时间" sortable />
    <el-table-column label="操作">
      <template #default="props">
        <el-button v-if="props.row.isIn==0" type="primary" title="确定入库" @click="confirmInstore(props.row)" :key="props.row.insId">确定入库</el-button>
      </template>
    </el-table-column>
  </el-table>
  <!-- 分页 -->
  <el-pagination
    background
    :total="params.totalNum"
    :page-sizes="[5, 10, 15, 20, 25, 30]"
    v-model:page-size="params.pageSize"
    v-model:currentPage="params.pageNum"
    layout="total, sizes, prev, pager, next, jumper"
    style="margin-top: 20px;"
    @size-change="changeSize"
    @current-change="changeCurrent"
  />
  
</template>

<script setup>
import { reactive, ref } from 'vue';
import { get, put, tip, export2excel } from "@/common";
import { useRoute } from 'vue-router'
import { Search, Edit, Check, Message, Star, Delete } from '@element-plus/icons-vue'

const route = useRoute(); // 获取路由信息

// 分页模糊查询数据
const params = reactive({
  storeId: 1,
  productName: '',
  startTime: '',
  endTime: '',
  pageSize: 5,
  pageNum: 1,
  totalNum: 0
})

// 表格数据
const instorePageList = ref();

// 获取分页模糊查询结果
const getInstorePageList = () => {
  // 如果从添加入库单跳过来，会传参storeId
  if(route.query.storeId){
    params.storeId = parseInt(route.query.storeId);
  }
  // 后台获取查询结果
  get("/instore/instore-page-list", params).then(result => {
    instorePageList.value = result.data.resultList;
    params.totalNum = result.data.totalNum;
  });
}
getInstorePageList();

// 所有仓库
const storeList = ref();
// 获取所有仓库
const getStoreList = () => {
  get("/instore/store-list").then(result => {
    storeList.value = result.data;
  });
}
getStoreList();

// 导出数据
const export2Table = () => {
  get("/instore/exportTable", params).then(result => {
    // 要导出的数据
    const instoreList = result.data;
    // 将isIn字段的0、1转化为是否
    instoreList.reduce((pre, cur) => {
      cur.isIn = cur.isIn==1?"已入库":"未入库";
      return pre;
    }, []);
    const columns = [
      {"title": "入库单ID", "key": "insId"},
      {"title": "仓库名", "key": "storeName"},
      {"title": "商品名", "key": "productName"},
      {"title": "入库数量", "key": "inNum"},
      {"title": "入库价格", "key": "inPrice"},
      {"title": "入库状态", "key": "isIn"},
      {"title": "创建人", "key": "userCode"},
      {"title": "创建时间", "key": "createTime"},
    ];
    export2excel(columns, instoreList, "入库单列表");
  });
}

// 确定入库
const confirmInstore = (instore) => {
  put('/instore/instore-confirm', instore).then(res => {
    tip.success(res.message);
    getInstorePageList();
  });
}

// 修改每页显示条数
const changeSize = (size) => {
  params.pageSize = size;
  // 重新查询
  getInstorePageList();
}
// 修改当前页码
const changeCurrent = (num) => {
  params.pageNum = num;
  // 重新查询
  getInstorePageList();
}
</script>

<style scoped>
.searchForm{
  margin-top: 20px;
  display: flex;
}
.red{
  color: red;
}
.green{
  color: green;
}
</style>