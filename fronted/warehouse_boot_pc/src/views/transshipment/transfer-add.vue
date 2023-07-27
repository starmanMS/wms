<template>
  <!-- 添加调货单对话框 -->
  <el-dialog v-model="visible" title="添加调货单" width="500px" @close="close" destroy-on-close>
    <el-form ref="transferAddForm" :model="transferAdd" :rules="rules" label-position="top">
      <el-form-item label="商品名称：" prop="productName">
        <el-input v-model="transferAdd.productName" disabled />
      </el-form-item>
      <el-form-item label="商品编号：" prop="targetProductNum">
        <el-input v-model="transferAdd.targetProductNum" />
      </el-form-item>
      <el-form-item label="库存：" prop="productInvent">
        <el-input v-model="transferAdd.productInvent" disabled />
      </el-form-item>
      <el-form-item label="调货数量：" prop="transNum">
        <el-input v-model="transferAdd.transNum" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="addTransfer">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { get, post, tip } from "@/common"

// 该页面的可见性
const visible = ref(false);

// 添加调货对象
const transferAdd = reactive({
  productName: '',
  targetProductNum: '',
  productInvent: '',
  transNum: '',
  sourceStoreId: '',
  sourceProductId: '',
  targetStoreId: ''
});

// 验证商品编号的唯一性
const validateProductNum = async(rule, productNum, callback) => {
  if (productNum === '') return callback(new Error('请输入商品编号！'));
  const res = await get(`/transshipment/product-num-check?productNum=${productNum}`);
  if(!res.data) return callback(new Error('商品编号已存在！'));
  return true;
}

// 调货数量大于0，并且小于等于库存
const validateTransNum = (rule, transNum, callback) => {
  if (transNum === '') return callback(new Error('请输入调货数量！'));
  // 库存
  const productInvent = parseInt(transferAdd.productInvent);
  if(parseInt(transNum)<=0) return callback(new Error('调货数量必须大于0！'));
  if(parseInt(transNum)>productInvent) return callback(new Error('调货数量不能大于库存！'));
  return true;
}

// 表单验证规则
const rules = reactive({
  targetProductNum: [
    { validator: validateProductNum, trigger: 'blur' }
  ],
  transNum: [
    { validator: validateTransNum, trigger: 'blur' }
  ]
})

// 关闭
const close = () => {
  for(let prop in transferAdd){
    transferAdd[prop] = '';
  }
  
  visible.value = false;
}

// 该对话框打开，进行数据初始化
const open = (commodity, targetStoreId) => {
  visible.value = true;
  transferAdd.productName = commodity.productName;
  transferAdd.targetProductNum = commodity.productNum;
  transferAdd.productInvent = commodity.productInvent;
  transferAdd.sourceStoreId = commodity.storeId;
  transferAdd.sourceProductId = commodity.productId;
  transferAdd.targetStoreId = targetStoreId;
};

const transferAddForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加调货单提交
const addTransfer = () => {
  transferAddForm.value.validate(valid => {
    if(valid){
      post('/transshipment/transshipment-add', transferAdd).then(result => {
        emit('ok');
        tip.success(result.message);
        visible.value = false; // 关闭对话框
      });
    }
  });
}

defineExpose({ open });
</script>

<style>


</style>