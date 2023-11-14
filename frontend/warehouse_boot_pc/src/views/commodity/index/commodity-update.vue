<template>
  <!-- 修改商品对话框 -->
  <el-dialog v-model="visible" title="修改商品" width="50%" @close="close" destroy-on-close>
    <el-form ref="commodityUpdateRef" :model="commodityUpdate" :rules="rules" label-position="right" label-width="100px">
      <el-form-item label="商品图片：" prop="imgs">
        <el-upload
          class="avatar-uploader"
          :action="WAREHOUSE_CONTEXT_PATH + '/product/img-upload'"
          :show-file-list="false"
          :on-change="handleAvatarChange"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="imageUrl" :src="imageUrl" class="avatar" />
          <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
        </el-upload>
      </el-form-item>
      <el-row>
          <el-form-item label="名称：" prop="productName">
            <el-input v-model="commodityUpdate.productName" />
          </el-form-item>
          <el-form-item label="编号：" prop="productNum">
            <el-input v-model="commodityUpdate.productNum" />
          </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="种类：" prop="typeId">
          <el-popover trigger="click" placement="bottom-start" width="12%" >
            <template #reference>
              <el-input v-model="commodityUpdate.typeName" placeholder="选择类型" readonly />
            </template>
            <el-tree :node-key="typeId" :data="categorys" :props="defaultProps" @node-click="handleNodeClick" />
          </el-popover>
        </el-form-item>
        <el-form-item label="库存：" prop="productInvent">
          <el-input-number v-model="commodityUpdate.productInvent" min="0" />
        </el-form-item>
      </el-row>
      <el-row>
          <el-form-item label="品牌：" prop="brandId">
            <el-select placeholder="请选择品牌" v-model="commodityUpdate.brandId" clearable>
              <el-option v-for="brand of brands" :label="brand.brandName" :value="brand.brandId" :key="brand.brandId"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="仓库：" prop="storeId">
            <el-select placeholder="请选择仓库" v-model="commodityUpdate.storeId" clearable>
              <el-option v-for="store of stores" :label="store.storeName" :value="store.storeId" :key="store.storeId"></el-option>
            </el-select>
          </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="供应商：" prop="supplyId">
          <el-select placeholder="请选择供应商" v-model="commodityUpdate.supplyId" clearable>
            <el-option v-for="supply of supplys" :label="supply.supplyName" :value="supply.supplyId" :key="supply.supplyId"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="产地：" prop="placeId">
          <el-select placeholder="请选择产地" v-model="commodityUpdate.placeId" clearable>
            <el-option v-for="place of places" :label="place.placeName" :value="place.placeId" :key="place.placeId"></el-option>
          </el-select>
        </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="单位：" prop="unitId">
          <el-select placeholder="请选择单位" v-model="commodityUpdate.unitId" clearable>
            <el-option v-for="unit of units" :label="unit.unitName" :value="unit.unitId" :key="unit.unitId"></el-option>
          </el-select>
        </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="进价：" prop="inPrice">
          <el-input v-model="commodityUpdate.inPrice" style="width: 90%;" />元
        </el-form-item>
        <el-form-item label="售价：" prop="salePrice">
          <el-input v-model="commodityUpdate.salePrice" style="width: 90%;" />元
        </el-form-item>
      </el-row>
      <el-row>
        <el-form-item label="会员价：" prop="memPrice">
          <el-input v-model="commodityUpdate.memPrice" style="width: 90%;" />元
        </el-form-item>
      </el-row>
      <el-form-item label="详细介绍：" prop="introduce" style="width: 88%;">
        <el-input type="textarea" rows="2" v-model="commodityUpdate.introduce" />
      </el-form-item>
      <el-row>
        <el-form-item label="生产日期：" prop="productDate">
          <el-input type="date" v-model="commodityUpdate.productDate" />
        </el-form-item>
        <el-form-item label="保质期：" prop="suppDate">
          <el-input type="date" v-model="commodityUpdate.suppDate" />
        </el-form-item>
      </el-row>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="updateCommodity">确定</el-button>
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
// 图片回显路径
const imageUrl = ref('');

// 添加文件时的回显
const handleAvatarChange = (uploadFile) => {
  const reader = new FileReader();
  // 从上传组件中获取数据
  const image = uploadFile.raw;
  reader.readAsDataURL(image);
  // 读取文件的回调函数
  reader.onload = () => {
      // 将转化的url赋值给文件
      imageUrl.value = reader.result;
      commodityUpdate.imgs = image.name;
  };
}

// 上传之前做简单验证
const beforeAvatarUpload = (rawFile) => {
  if (rawFile.type !== 'image/jpg'
    && rawFile.type !== 'image/jpeg'
    && rawFile.type !== 'image/png'
    && rawFile.type !== 'image/gif'
    && rawFile.type !== 'image/svg'
    && rawFile.type !== 'image/webp'
    ) {
    tip.error('只能上传图片格式!');
    return false
  } else if (rawFile.size / 1024 / 1024 > 5) {
    tip.error('上传文件不能大于5MB!');
    return false
  }
  return true
}

// 修改商品对象
const commodityUpdate = reactive({
  imgs: '',
  productId: '',
  productName: '',
  storeId: '',
  brandId: '',
  productNum: '',
  productInvent: 0,
  typeId: '',
  typeName: '',
  supplyId: '',
  placeId: '',
  unitId: '',
  introduce: '',
  inPrice: 0,
  salePrice: 0,
  memPrice: 0,
  productDate: '',
  suppDate: ''
});

// 表单验证规则
const rules = reactive({
  productName: [
    { required: true, message: '请输入商品名称', trigger: 'blur' }
  ],
  storeId: [
    { required: true, message: '请选择仓库', trigger: 'blur' }
  ],
  brandId: [
    { required: true, message: '请选择品牌', trigger: 'blur' }
  ],
  productNum: [
    { required: true, message: '请输入商品编号', trigger: 'blur' }
  ],
  supplyId: [
    { required: true, message: '请选择供应商', trigger: 'blur' }
  ],
  placeId: [
    { required: true, message: '请选择产地', trigger: 'blur' }
  ],
  unitId: [
    { required: true, message: '请选择单位', trigger: 'blur' }
  ],
})

// 关闭
const close = () => {
  visible.value = false;
}

// 所有仓库
const stores = ref();
// 所有品牌
const brands = ref();
// 所有分类
const categorys = ref();
// 所有供应商
const supplys = ref();
// 所有产地
const places = ref();
// 所有单位
const units = ref();

// 树形结构数据对应实体类属性
const defaultProps = {
  children: 'childGoodsCategory',
  label: 'typeName',
}

// 点击二级分类，显示到输入框
const handleNodeClick = (type) => {
  if(type && type.parentId!=0){
    // 选择二级分类
    commodityUpdate.typeId = type.typeId;
    commodityUpdate.typeName = type.typeName;
  }
}

// 该对话框打开，进行数据初始化
const open = (commodity, storeList, brandList, categoryTree, supplyList, placeList, unitList) => {
  visible.value = true;
  // 服务器中的图片地址
  imageUrl.value = WAREHOUSE_CONTEXT_PATH + commodity.imgs;

  for(let prop in commodity){
    commodityUpdate[prop] = commodity[prop];
  }
  
  stores.value = storeList.value;
  brands.value = brandList.value;
  categorys.value = categoryTree.value;
  supplys.value = supplyList.value;
  places.value = placeList.value;
  units.value = unitList.value;
};

const commodityUpdateRef = ref();
// 定义
const emit = defineEmits(["ok"]);
// 添加商品提交
const updateCommodity = () => {
  commodityUpdateRef.value.validate(valid => {
    if(valid){
      put('/product/product-update', commodityUpdate).then(result => {
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