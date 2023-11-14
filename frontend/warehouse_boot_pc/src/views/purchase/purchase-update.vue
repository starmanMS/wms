<template>
  <!-- 修改采购单对话框 -->
  <el-dialog v-model="visible" title="修改采购单" width="400px" @close="close" destroy-on-close>
    <el-form ref="purchaseUpdateForm" :model="purchaseUpdate" :rules="rules" label-position="top" label-width="120px">
      <el-form-item label="采购单号：" prop="buyId">
        <el-input v-model="purchaseUpdate.buyId" disabled />
      </el-form-item>
      <el-form-item label="仓库：" prop="storeName">
        <el-input v-model="purchaseUpdate.storeName" disabled />
      </el-form-item>
      <el-form-item label="商品名称：" prop="productName">
        <el-input v-model="purchaseUpdate.productName" disabled />
      </el-form-item>
      <el-form-item label="预计采购数量：" prop="buyNum">
        <el-input v-model="purchaseUpdate.buyNum" controls-position="right" />
      </el-form-item>
      <el-form-item label="实际采购数量：" prop="factBuyNum">
        <el-input v-model="purchaseUpdate.factBuyNum" controls-position="right" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="updatePurchase">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip } from "@/common"

// 该页面的可见性
const visible = ref(false);

// 添加采购单对象
const purchaseUpdate = reactive({
  buyId: '',
  storeName: '',
  productName: '',
  buyNum: '',
  factBuyNum: ''
});

// 表单验证规则
const rules = reactive({
  buyNum: [
    { required: true, message: '请输入预计采购数量', trigger: 'blur' }
  ],
  factBuyNum: [
    { required: true, message: '请输入实际采购数量', trigger: 'blur' }
  ]
})

// 关闭
const close = () => {
  visible.value = false;
}

// 该对话框打开，进行数据初始化
const open = (purchase) => {
  for(let prop in purchase){
    purchaseUpdate[prop] = purchase[prop];
  }
  visible.value = true;
};

const purchaseUpdateForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加采购单提交
const updatePurchase = () => {
  purchaseUpdateForm.value.validate((valid) => {
    if(valid){
      put('/purchase/purchase-update', purchaseUpdate).then(result => {
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