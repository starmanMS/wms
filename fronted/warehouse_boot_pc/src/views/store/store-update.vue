<template>
  <!-- 修改仓库对话框 -->
  <el-dialog v-model="visible" title="修改仓库" width="400px" @close="close" destroy-on-close>
    <el-form ref="storeUpdateRef" :model="storeUpdate" :rules="rules" label-position="right" label-width="100px">
      <el-form-item label="编号：" prop="storeNum">
        <el-input v-model="storeUpdate.storeNum" disabled />
      </el-form-item>
      <el-form-item label="名称：" prop="storeName">
        <el-input v-model="storeUpdate.storeName" />
      </el-form-item>
      <el-form-item label="地址：" prop="storeAddress">
        <el-input v-model="storeUpdate.storeAddress" />
      </el-form-item>
      <el-form-item label="联系人：" prop="concat">
        <el-input v-model="storeUpdate.concat" />
      </el-form-item>
      <el-form-item label="电话：" prop="phone">
        <el-input v-model="storeUpdate.phone" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="updateStore">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip, WAREHOUSE_CONTEXT_PATH } from "@/common"
import { Plus } from '@element-plus/icons-vue'

// 该页面的可见性
const visible = ref(false);


// 修改仓库对象
const storeUpdate = reactive({
  storeName: '',
  storeNum: '',
  storeAddress: '',
  concat: '',
  phone: '',
});

// 表单验证规则
const rules = reactive({
  storeName: [
    { required: true, message: '请输入仓库名称', trigger: 'blur' }
  ]
})

// 关闭
const close = () => {
  visible.value = false;
}

// 该对话框打开，进行数据初始化
const open = (store) => {
  visible.value = true;

  for(let prop in store){
    storeUpdate[prop] = store[prop];
  }
};

const storeUpdateRef = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加仓库提交
const updateStore = () => {
  storeUpdateRef.value.validate(valid => {
    if(valid){
      put('/store/store-update', storeUpdate).then(result => {
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