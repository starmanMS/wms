<template>
  <!-- 添加商品分类对话框 -->
  <el-dialog v-model="visible" title="添加商品分类" width="40%" @close="close" destroy-on-close>
    <el-form ref="categoryAddForm" :model="categoryAdd" :rules="rules" label-position="right" label-width="100px">
      <el-form-item label="分类编码：" prop="typeCode">
        <el-input v-model="categoryAdd.typeCode" />
      </el-form-item>
      <el-form-item label="分类名称：" prop="typeName">
        <el-input v-model="categoryAdd.typeName" />
      </el-form-item>
      <el-form-item label="分类描述：" prop="typeDesc">
        <el-input type="textarea" rows="4" v-model="categoryAdd.typeDesc" />
      </el-form-item>
    </el-form> 
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="addCategory">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { get, post, tip } from "@/common"

// 该页面的可见性
const visible = ref(false);

// 添加商品分类对象
const categoryAdd = reactive({
  parentId: '',
  typeCode: '',
  typeName: '',
  typeDesc: ''
});

// 检查分类编码的唯一性
const validateCode = async(rule, typeCode, callback) => {
  typeCode = typeCode.trim();
  if(typeCode === '') return callback(new Error('请输入分类编码！'));
  const res = await get(`/productCategory/verify-type-code?typeCode=${typeCode}`);
  if(!res.data) return callback(new Error('该分类编码已存在！'));
  return true;
}

// 输入框内容的基本规则
const rules = reactive({
  typeCode: [
    { validator: validateCode, trigger: 'blur' }
  ],
  typeName: [
    { required: true, message: '分类名称不能为空！', trigger: 'blur' }
  ]
});

// 关闭
const close = () => {
  for(let prop in categoryAdd){
    categoryAdd[prop] = '';
  }
  visible.value = false;
}

// 该对话框打开，进行数据初始化
const open = (productCategory) => {
  visible.value = true;
  
  if(productCategory){
    // 当前选中一级分类，添加该一级分类的子分类，父id为一级分类的typeId
    categoryAdd.parentId = productCategory.typeId;
  }else{
    // 当前未选中分类，添加一级分类，父id为0
    categoryAdd.parentId = 0;
  }
};

const categoryAddForm = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加商品提交
const addCategory = () => {
  categoryAddForm.value.validate(valid => {
    if(valid){
      post('/productCategory/type-add', categoryAdd).then(result => {
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