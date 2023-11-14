<template>
  <!-- 修改用户对话框 -->
  <el-dialog v-model="visible" title="修改用户信息" width="25%">
    <el-form ref="userUpdateForm" :model="userUpdate" label-position="top">
      <el-form-item label="用户名：">
        <el-input v-model="userUpdate.userCode" autocomplete="off" disabled />
      </el-form-item>
      <el-form-item label="昵称：">
        <el-input v-model="userUpdate.userName" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="visible=false">取消</el-button>
        <el-button type="primary" @click="updateUser">确认修改</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip } from "@/common";

const visible = ref(false); // 该页面的可见性
// 修改用户对象
const userUpdate = reactive({
  userId: '',
  userCode: '',
  userName: ''
});

// 该对话框打开并初始化
const open = (user) => {
  userUpdate.userId = user.userId;
  userUpdate.userCode = user.userCode;
  userUpdate.userName = user.userName;
  visible.value = true;
};

const userUpdateForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 修改用户提交
const updateUser = () => {
  userUpdateForm.value.validate(valid => {
    if(valid){
      put('/user/updateUser', userUpdate).then(result => {
        emit('ok');
        tip.success(result.message);
        visible.value = false; // 关闭对话框
      });
    }
  });
}

defineExpose({ open });
</script>
<style scoped>

</style>