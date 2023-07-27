<template>
  <h2>权限列表</h2>
  <el-divider></el-divider>
  <div style="padding-bottom: 20px;">
    <el-button @click="updateAuth">确认修改</el-button>
    <el-button type="primary" @click="goBack">取消</el-button>
  </div>
  <!-- 权限列表 -->
  <el-tree
    ref="authTreeRef"
    :data="data"
    :props="props"
    node-key="authId"
    :default-checked-keys="checkedKeys"
    show-checkbox
    @node-click="handleNodeClick"
  />
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { get, put, tip } from "@/common";

const route = useRoute(); // 获取路由信息
const router = useRouter(); // 获取路由器

const handleNodeClick = (data) => {
  // console.log(data)
}

// 点击取消
const goBack = function(){
  router.go(-1); // 返回
}

const props = {
  children: 'childAuth',
  label: 'authName',
  disabled: data => data.authState==0
}

const data = ref([]);
// 获取所有权限
const getAllAuth = () => {
  get('/auth/auth-tree').then(result => {
    data.value = result.data;
  });
}
getAllAuth();

let userId;
// 选中列表
const checkedKeys = ref([]);
// 获取用户已有的权限id
const getUserAuthList = () => {
  userId = route.query.userId;
  get(`/user/user-auth?userId=${userId}`).then(result => {
    checkedKeys.value = result.data;
  });
}
getUserAuthList();

const authTreeRef = ref();
// 确认修改
const updateAuth = () => {
  checkedKeys.value = authTreeRef.value.getCheckedKeys(false);
  put("/user/auth-grant", {"userId": userId, "authIds": checkedKeys.value}).then(result => {
    tip.success(result.message);
    router.go(-1); // 返回
  });

}

</script>
<style scoped>
.el-tree{
  width: 60%;
  padding: 5px 0 50px;
  border: 1px solid #CCC;
  background-color: #F0F6E4;
}
</style>