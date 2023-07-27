<template>
  <!-- 修改角色对话框 -->
  <el-dialog v-model="visible" title="修改角色信息" width="25%">
    <el-form ref="roleUpdateForm" :model="roleUpdate" label-position="top">
      <el-form-item label="名称：">
        <el-input v-model="roleUpdate.roleName" autocomplete="off" disabled />
      </el-form-item>
      <el-form-item label="描述：">
        <el-input v-model="roleUpdate.roleDesc" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="visible=false">取消</el-button>
        <el-button type="primary" @click="updateRole">确认修改</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip } from "@/common";

const visible = ref(false); // 该页面的可见性
// 修改角色对象
const roleUpdate = reactive({
  roleId: '',
  roleName: '',
  roleDesc: ''
});

// 该对话框打开并初始化
const open = (role) => {
  roleUpdate.roleId = role.roleId;
  roleUpdate.roleName = role.roleName;
  roleUpdate.roleDesc = role.roleDesc;
  visible.value = true;
};

const roleUpdateForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 修改用户提交
const updateRole = () => {
  roleUpdateForm.value.validate(valid => {
    if(valid){
      put('/role/role-update', roleUpdate).then(result => {
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