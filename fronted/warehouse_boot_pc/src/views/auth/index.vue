<template>
  <div style="padding-bottom: 20px;">
    <el-button type="primary" @click="openAuthAdd">添加权限</el-button>
    <el-button type="primary" @click="openAuthUpdate">修改权限</el-button>
    <el-button type="warning" @click="enableAuth">启用权限</el-button>
    <el-button type="danger" @click="disableAuth">禁用权限</el-button>
    <el-button type="primary" @click="deleteAuth">删除权限</el-button>
  </div>
  <!-- 权限列表 -->
  <el-tree
    ref="authTreeRef"
    :data="data"
    :props="props"
    node-key="authId"
    @check="handleCheck"
    :default-checked-keys="checkedKeys"
    show-checkbox
    check-strictly
  />
    
  <!-- 修改权限对话框 -->
  <auth-update ref="authUpdateRef" @ok="getAuthTree"></auth-update>
  
  <!-- 添加权限对话框 -->
  <auth-add ref="authAddRef" @ok="getAuthTree"></auth-add>

</template>

<script setup>
import { ref } from 'vue';
import { get, put, del, tip } from "@/common";

const currNode = ref(); // 当前选中的节点对象

const props = {
  children: 'childAuth',
  label: 'authName',
  /* 将禁用的权限置灰处理 */
  class: data => data.authState=='0'?'gray':''
}

const data = ref([]);
// 获取所有权限
const getAuthTree = () => {
  get('/auth/auth-tree').then(result => {
    data.value = result.data;
    authTreeRef.value.setCheckedKeys([]); // 取消之前的选中的节点
    currNode.value = null; // 当前选中节点置为null
  });
}
getAuthTree();

const authTreeRef = ref();
// 点击复选框时,实现单选
const handleCheck = (node, resolve) => {
  // node 当前点击的节点对象
  // resolve 选中状态对象
  if(resolve.checkedKeys.length>0){
    // 只要当前有选中的节点，就设置为最近一次选中的节点
    authTreeRef.value.setCheckedKeys([node.authId]);
    currNode.value = node; // 当前选中的节点
  }else{
    currNode.value = null; // 如果没有选中，当前节点重置为null
  }
}

// 点击修改权限按钮
import AuthUpdate from "./auth-update.vue";
const authUpdateRef = ref();
const openAuthUpdate = () => {
  if(currNode.value){
    authUpdateRef.value.open(currNode.value);
  }else{
    tip.error("请选择一个权限！");
  }
};

// 点击添加权限按钮
import AuthAdd from "./auth-add.vue";
const authAddRef = ref();
const openAuthAdd = () => {
  if(!currNode.value || currNode.value.authGrade<3){
    authAddRef.value.open(currNode.value);
  }else{
    tip.error("当前权限不能添加子权限！");
  }
};

// 启用权限
const enableAuth = () => {
  put(`/auth/auth-enable/${currNode.value.authId}`).then(result => {
    tip.success(result.message);
    getAuthTree();
  });
}

// 禁用权限
const disableAuth = () => {
  put(`/auth/auth-disable/${currNode.value.authId}`).then(result => {
    tip.success(result.message);
    getAuthTree();
  });
}

// 删除权限
const deleteAuth = () => {
  del(`/auth/auth-delete/${currNode.value.authId}`, null, { title: "提示", message: "您确定删除该权限及其子权限吗？" }).then(result => {
    tip.success(result.message);
    getAuthTree();
  });
}


</script>

<!-- el-tree的样式需要去掉scoped -->
<style>
.el-tree{
  width: 60%;
  padding: 5px 0 50px;
  border: 1px solid #CCC;
  background-color: #F0F6E4;
}
.gray>.el-tree-node__content{
  color: #CCC;
}
</style>