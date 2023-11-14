<template>
  <!-- 添加权限对话框 -->
  <el-dialog v-model="visible" title="添加权限" width="25%" @close="close" destroy-on-close>
    <el-form ref="authAddForm" :model="authAdd" :rules="rules" label-position="top">
      <el-form-item label="名称：" prop="authName">
        <el-input v-model="authAdd.authName" autocomplete="off" />
      </el-form-item>
      <el-form-item label="权限描述：" prop="authDesc">
        <el-input v-model="authAdd.authDesc" autocomplete="off" />
      </el-form-item>
      <el-form-item v-if="authAdd.authGrade>1" label="权限url：" prop="authUrl">
        <el-input v-model="authAdd.authUrl" autocomplete="off" />
      </el-form-item>
      <el-form-item v-if="authAdd.authGrade==3" label="权限code：" prop="authCode">
        <el-input v-model="authAdd.authCode" autocomplete="off" />
      </el-form-item>
      <el-form-item label="分类">
        <el-select v-model="type">
          <el-option label="模块" value="1" :selected="authAdd.authGrade==1" :disabled="authAdd.authGrade>1" />
          <el-option label="列表" value="2" :selected="authAdd.authGrade==2" :disabled="authAdd.authGrade!=2" />
          <el-option label="按钮" value="3" :selected="authAdd.authGrade==3" :disabled="authAdd.authGrade<3" />
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="addAuth">添加</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { get, post, tip } from '@/common';

const visible = ref(false); // 该页面的可见性
// 添加权限对象
const authAdd = reactive({
  parentId: 0,
  authName: '',
  authDesc: '',
  authUrl: '',
  authCode: '',
  authGrade: 0,
  authType: ''
});

// 关闭
const close = () => {
  // 重置authAdd中的属性
  for(let prop in authAdd){
    authAdd[prop] = '';
  }

  visible.value = false;
}

// 类型
const type = ref();

// 该对话框打开并初始化
const open = (auth) => {
  visible.value = true;
  if(!auth){
    // 当前没有选中任何权限，添加一级权限
    authAdd.authType = 1;
    authAdd.authGrade = 1;
    authAdd.parentId = 0;
    type.value = '模块';
  }else{
    // 指定父级id
    authAdd.parentId = auth.authId;
    if(auth.authGrade==1){
      // 当前选中一级权限，添加二级权限
      authAdd.authType = 2;
      authAdd.authGrade = 2;
      type.value = '列表';
    }else if(auth.authGrade==2){
      // 当前选中二级权限，添加三级权限
      authAdd.authType = 3;
      authAdd.authGrade = 3;
      type.value = '按钮';
    }
  }
 
};

// 检查name的唯一性
const validateName = async(rule, authName, callback) => {
  authName = authName.trim();
  if(authName === '') return callback(new Error('请输入权限名称！'));
  const res = await get(`/auth/name-check?authName=${authName}`);
  if(!res.data) return callback(new Error('该权限名称已存在！'));
  return true;
}

// 检查url的唯一性
const validateUrl = async(rule, authUrl, callback) => {
  authUrl = authUrl.trim();
  if(authUrl === '') return callback(new Error('请输入权限url！'));
  const res = await get(`/auth/url-check?authUrl=${authUrl}`);
  if(!res.data) return callback(new Error('该权限url已存在！'));
  return true;
}

// 检查code的唯一性
const validateCode = async(rule, authCode, callback) => {
  authCode = authCode.trim();
  if(authCode === '') return callback(new Error('请输入权限code！'));
  const res = await get(`/auth/code-check?authCode=${authCode}`);
  if(!res.data) callback(new Error('该权限code已存在！'));
  return true;
}

// 输入框内容的基本规则
const rules = reactive({
  authName: [
    { validator: validateName, trigger: 'blur' }
  ],
  authUrl: [
    { validator: validateUrl, trigger: 'blur' }
  ],
  authCode: [
    { validator: validateCode, trigger: 'blur' }
  ],
})

const authAddForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加权限提交
const addAuth = () => {
  authAddForm.value.validate(valid => {
    if(valid){
      post('/auth/auth-add', authAdd).then(result => {
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