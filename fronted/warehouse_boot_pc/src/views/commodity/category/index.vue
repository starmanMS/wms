<template>
  <!-- 商品分类 -->
  <div style="padding-bottom: 20px;">
    <el-button type="primary" @click="openCategoryAdd">添加分类</el-button>
    <el-button type="primary" @click="openCategoryUpdate">修改分类</el-button>
    <el-button type="danger" @click="deleteCategory">删除分类</el-button>
  </div>

  <!-- 分类树 -->
  <el-tree
    ref="categoryTreeRef"
    :data="categoryData"
    :props="props"
    node-key="typeId"
    @check="handleCheck"
    :default-checked-keys="checkedKeys"
    show-checkbox
    check-strictly
  />

  <!-- 添加分类对话框 -->
  <category-add ref="categoryAddRef" @ok="getCategoryTree"></category-add>
  
  <!-- 修改分类对话框 -->
  <category-update ref="categoryUpdateRef" @ok="getCategoryTree"></category-update>

</template>

<script setup>
import { ref } from 'vue';
import { get, del, tip } from "@/common";

const currNode = ref(); // 当前选中的节点对象

// 树形结构数据对应实体类属性
const props = {
  children: 'childProductCategory',
  label: 'typeName'
}

// 分类树数据
const categoryData = ref();

// 获取所有分类
const getCategoryTree = () => {
  get("/productCategory/product-category-tree").then(result => {
    categoryData.value = result.data;
    categoryTreeRef.value.setCheckedKeys([]); // 取消之前的选中的节点
    currNode.value = null; // 当前选中节点置为null
  });
}
getCategoryTree();

// 分类树对象
const categoryTreeRef = ref();
// 点击复选框时,实现单选
const handleCheck = (node, resolve) => {
  // node 当前点击的节点对象
  // resolve 选中状态对象
  if(resolve.checkedKeys.length>0){
    // 只要当前有选中的节点，就设置为最近一次选中的节点
    categoryTreeRef.value.setCheckedKeys([node.typeId]);
    currNode.value = node; // 当前选中的节点
  }else{
    currNode.value = null; // 如果没有选中，当前节点重置为null
  }
}

// 点击添加分类按钮
import CategoryAdd from "./category-add.vue";
const categoryAddRef = ref();
const openCategoryAdd = () => {
  // 当前未选中分类，添加一级分类
  // 当前选中一级分类，添加该一级分类的子分类
  if(!currNode.value || currNode.value.parentId==0){
    categoryAddRef.value.open(currNode.value);
  }else{
    tip.error("该分类已是最小分类，不能添加子分类！");
  }
};

// 点击修改分类按钮
import CategoryUpdate from "./category-update.vue";
const categoryUpdateRef = ref();
const openCategoryUpdate = () => {
  if(currNode.value){
    categoryUpdateRef.value.open(currNode.value);
  }else{
    tip.error("请选择一个商品分类！");
  }
};

// 删除商品分类
const deleteCategory = () => {
  del(`/productCategory/type-delete/${currNode.value.typeId}`, null, { title: "提示", message: "您确定删除该分类及其子分类吗？" }).then(result => {
    tip.success(result.message);
    getCategoryTree();
  });
}
</script>

<style scoped>
.searchForm{
  margin-top: 20px;
  display: flex;
}
.el-tree{
  width: 60%;
  padding: 5px 0 50px;
  border: 1px solid #CCC;
  background-color: #F0F6E4;
}
</style>