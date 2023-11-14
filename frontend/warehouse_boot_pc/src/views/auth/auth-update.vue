<template>
  <!-- 修改权限对话框 -->
  <el-dialog v-model="visible" title="修改权限信息" width="25%">
    <el-form ref="authUpdateForm" :model="authUpdate" :rules="rules" label-position="top">
      <el-form-item label="名称：" prop="authName">
        <el-input v-model="authUpdate.authName" autocomplete="off" />
      </el-form-item>
      <el-form-item label="权限描述：" prop="authDesc">
        <el-input v-model="authUpdate.authDesc" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="visible=false">取消</el-button>
        <el-button type="primary" @click="updateAuth">确认修改</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip } from "@/common";

const visible = ref(false); // 该页面的可见性
// 修改权限对象
const authUpdate = reactive({
  authId: '',
  authName: '',
  authDesc: ''
});

// 该对话框打开并初始化
const open = (auth) => {
  authUpdate.authId = auth.authId;
  authUpdate.authName = auth.authName;
  authUpdate.authDesc = auth.authDesc;
  visible.value = true;
};

// 输入框内容的基本规则
const rules = reactive({
  authName: [
    { required: true, message: '请输入权限名称', trigger: 'blur' }
  ]
})

const authUpdateForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 修改权限提交
const updateAuth = () => {
  authUpdateForm.value.validate(valid => {
    if(valid){
      put('/auth/auth-update', authUpdate).then(result => {
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