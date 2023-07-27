<template>
  <!-- 修改商品分类对话框 -->
  <el-dialog v-model="visible" title="修改商品分类" width="40%" @close="close" destroy-on-close>
    <el-form ref="categoryUpdateForm" :model="categoryUpdate" :rules="rules" label-position="right" label-width="100px">
      <el-form-item label="分类编码：" prop="typeCode">
        <el-input v-model="categoryUpdate.typeCode" disabled />
      </el-form-item>
      <el-form-item label="分类名称：" prop="typeName">
        <el-input v-model="categoryUpdate.typeName" />
      </el-form-item>
      <el-form-item label="分类描述：" prop="typeDesc">
        <el-input type="textarea" rows="4" v-model="categoryUpdate.typeDesc" />
      </el-form-item>
    </el-form> 
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="updateCategory">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { put, tip } from "@/common"

// 该页面的可见性
const visible = ref(false);

// 修改商品分类对象
const categoryUpdate = reactive({
  typeId: '',
  typeCode: '',
  typeName: '',
  typeDesc: ''
});

// 输入框内容的基本规则
const rules = reactive({
  typeName: [
    { required: true, message: '分类名称不能为空！', trigger: 'blur' }
  ]
});

// 关闭
const close = () => {
  visible.value = false;
}


// 该对话框打开，进行数据初始化
const open = (productCategory) => {
  visible.value = true;
  for(let prop in productCategory){
    categoryUpdate[prop] = productCategory[prop];
  }
};

const categoryUpdateForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加商品提交
const updateCategory = () => {
  categoryUpdateForm.value.validate(valid => {
    if(valid){
      put('/productCategory/type-update', categoryUpdate).then(result => {
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
.avatar-uploader, .avatar-uploader .avatar{
  width: 100px;
  height: 100px;
  display: block;
}
</style>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
}
</style>