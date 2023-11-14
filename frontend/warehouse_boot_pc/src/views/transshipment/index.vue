<template>
  <!-- 调货单列表-->
  <div>
    <el-form inline class="searchForm">
      <el-form-item label="目标仓库：">
        <el-select v-model="params.targetStoreId" placeholder="请选择仓库" style="width: 120px;" clearable>
          <el-option v-for="store of storeList" :label="store.storeName" :value="store.storeId" :key="store.storeId"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="源仓库：">
        <el-select v-model="params.sourceStoreId" placeholder="请选择仓库" style="width: 120px;" clearable>
          <el-option v-for="store of storeList" :label="store.storeName" :value="store.storeId" :key="store.storeId"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-input v-model="params.targetProductName" placeholder="目标商品名称" style="width: 130px;"  clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-input v-model="params.sourceProductName" placeholder="源商品名称" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-input v-model="params.createName" placeholder="调货人" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getTransshipmentPageList">
          <el-icon>
            <svg t="1646977561352" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3057" width="200" height="200"><path d="M986.304 871.424L747.328 630.4c-2.816-2.752-5.888-4.928-8.768-7.232 40.32-62.464 63.936-136.832 63.936-216.96 0-220.16-176.96-398.592-395.392-398.592C188.8 7.616 11.712 186.048 11.712 406.208s177.088 398.592 395.392 398.592a391.232 391.232 0 0 0 215.36-64.576c2.24 3.072 4.352 6.08 7.04 8.832l239.04 241.024a82.688 82.688 0 0 0 117.76 0 84.48 84.48 0 0 0 0-118.656m-579.2-192.512c-149.12 0-270.528-122.368-270.528-272.704 0-150.4 121.344-272.768 270.528-272.768 149.12 0 270.528 122.432 270.528 272.768 0 150.4-121.408 272.704-270.528 272.704" p-id="3058"></path></svg>
          </el-icon>
          &nbsp;查&nbsp;&nbsp;询
        </el-button>
      </el-form-item>
    </el-form>
  </div>

  <!-- 表格 -->
  <el-table :data="transshipmentPageList" style="width: 100%; margin-top: 10px;" table-layout="auto" size="large" border stripe>
    <el-table-column prop="transId" label="调货编号" sortable />
    <el-table-column prop="targetStoreName" label="目标仓库名" sortable />
    <el-table-column prop="targetProductName" label="目标商品名" sortable />
    <el-table-column prop="sourceStoreName" label="源仓库名" sortable />
    <el-table-column prop="sourceProductName" label="源商品名" sortable />
    <el-table-column prop="transNum" label="调货量" sortable />
    <el-table-column label="调货状态" sortable >
      <template #default="props">
        <span :class="{red:props.row.auditState==0, green: props.row.auditState==1}">{{ props.row.auditState==0?'未完成':'已完成' }}</span>
      </template>
    </el-table-column>
    <el-table-column prop="createName" label="调货人" sortable />
    <el-table-column prop="createTime" label="调货时间" sortable />
    <el-table-column label="操作">
      <template #default="props">
        <el-button type="primary" @click="confirmTransshipment(props.row)">确认调货</el-button>
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
import { get, put, del, tip } from "@/common";
import { Search, Edit, Check, Message, Star, Delete } from '@element-plus/icons-vue'

// 分页模糊查询数据
const params = reactive({
  targetStoreId: '',
  sourceStoreId: '',
  targetProductName: '',
  sourceProductName: '',
  createName: '',
  pageSize: 5,
  pageNum: 1,
  totalNum: 0
})

// 表格数据
const transshipmentPageList = ref();

// 获取分页模糊查询结果
const getTransshipmentPageList = () => {
  get("/transshipment/transshipment-page-list", params).then(result => {
    transshipmentPageList.value = result.data.resultList;
    params.totalNum = result.data.totalNum;
  });
}
getTransshipmentPageList();

// 所有仓库
const storeList = ref();
// 获取所有仓库
const getStoreList = () => {
  get("/transshipment/store-list").then(result => {
    storeList.value = result.data;
  });
}
getStoreList();

// 点击确认调货
const confirmTransshipment = transshipment => {
  put("/transshipment/transshipment-confirm", transshipment).then(res => {
    tip.success(res.message);
    getTransshipmentPageList();
  });
}


// 修改每页显示条数
const changeSize = (size) => {
  params.pageSize = size;
  // 重新查询
  getTransshipmentPageList();
}
// 修改当前页码
const changeCurrent = (num) => {
  params.pageNum = num;
  // 重新查询
  getTransshipmentPageList();
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