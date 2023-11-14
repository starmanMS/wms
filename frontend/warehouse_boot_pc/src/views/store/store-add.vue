<template>
  <!-- 添加仓库对话框 -->
  <el-dialog v-model="visible" title="添加仓库" width="400px" @close="close" destroy-on-close>
    <el-form ref="storeAddRef" :model="storeAdd" :rules="rules" label-position="top">
      <el-form-item label="名称：" prop="storeName">
        <el-input v-model="storeAdd.storeName" />
      </el-form-item>
      <el-form-item label="编号：" prop="storeNum">
        <el-input v-model="storeAdd.storeNum" />
      </el-form-item>
      <el-form-item label="地址：" prop="storeAddress">
        <el-input v-model="storeAdd.storeAddress" />
      </el-form-item>
      <el-form-item label="联系人：" prop="concat">
        <el-input v-model="storeAdd.concat" />
      </el-form-item>
      <el-form-item label="电话：" prop="phone">
        <el-input v-model="storeAdd.phone" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="addStore">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { get, post, tip, WAREHOUSE_CONTEXT_PATH } from "@/common"
import { Plus } from '@element-plus/icons-vue'

// 该页面的可见性
const visible = ref(false);

// 添加仓库对象
const storeAdd = reactive({
  storeName: '',
  storeNum: '',
  storeAddress: '',
  concat: '',
  phone: '',
});

// 验证仓库编号的唯一性
const validateStoreNum = async(rule, storeNum, callback) => {
  if (storeNum === '') return callback(new Error('请输入仓库编号！'));
  const res = await get(`/store/store-num-check?storeNum=${storeNum}`);
  if(!res.data) return callback(new Error('仓库编号已存在！'));
  return true;
}

// 表单验证规则
const rules = reactive({
  storeName: [
    { required: true, message: '请输入仓库名称', trigger: 'blur' }
  ],
  storeNum: [
    { validator: validateStoreNum, trigger: 'blur' }
  ]
})

// 关闭
const close = () => {
  for(let prop in storeAdd){
    storeAdd[prop] = '';
  }
  
  visible.value = false;
}

// 该对话框打开，进行数据初始化
const open = () => {
  visible.value = true;
};

const storeAddRef = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加商品提交
const addStore = () => {
  storeAddRef.value.validate(valid => {
    if(valid){
      post('/store/store-add', storeAdd).then(result => {
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