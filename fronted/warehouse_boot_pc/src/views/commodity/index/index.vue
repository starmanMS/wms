<template>
  <!-- 商品列表 -->
  <div>
    <el-form class="searchForm">
      <el-form-item>
        <el-select v-model="params.storeId" style="width: 120px;" clearable>
          <el-option v-for="store of storeList" :label="store.storeName" :value="store.storeId" :key="store.storeId"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-input v-model="params.productName" placeholder="商品名称" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-autocomplete
          v-model="params.brandName"
          :fetch-suggestions="brandSearch"
          value-key="brandName"
          clearable
          placeholder="品牌"
          style="width: 120px;"
        />
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-input v-model="params.typeName" placeholder="类型" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-input v-model="params.supplyName" placeholder="供应商" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-input v-model="params.placeName" placeholder="产地" style="width: 120px;"  clearable></el-input>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-select v-model="params.upDownState" placeholder="上/下架" style="width: 120px;" clearable>
          <el-option label="未上架" :value="0"></el-option>
          <el-option label="已上架" :value="1"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-select v-model="params.isOverDate" placeholder="已/未过期" style="width: 120px;" clearable>
          <el-option label="未过期" :value="0"></el-option>
          <el-option label="已过期" :value="1"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item style="margin-left: 10px;">
        <el-button type="primary" @click="getCommodityPageList">
          <el-icon>
            <svg t="1646977561352" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3057" width="200" height="200"><path d="M986.304 871.424L747.328 630.4c-2.816-2.752-5.888-4.928-8.768-7.232 40.32-62.464 63.936-136.832 63.936-216.96 0-220.16-176.96-398.592-395.392-398.592C188.8 7.616 11.712 186.048 11.712 406.208s177.088 398.592 395.392 398.592a391.232 391.232 0 0 0 215.36-64.576c2.24 3.072 4.352 6.08 7.04 8.832l239.04 241.024a82.688 82.688 0 0 0 117.76 0 84.48 84.48 0 0 0 0-118.656m-579.2-192.512c-149.12 0-270.528-122.368-270.528-272.704 0-150.4 121.344-272.768 270.528-272.768 149.12 0 270.528 122.432 270.528 272.768 0 150.4-121.408 272.704-270.528 272.704" p-id="3058"></path></svg>
          </el-icon>
          &nbsp;查&nbsp;&nbsp;询
        </el-button>
      </el-form-item>
    </el-form>
    <div>
      <el-button type="primary" @click="openCommodityAdd()">
        <el-icon>
          <svg t="1646977404025" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2197" width="200" height="200"><path d="M925.696 384q19.456 0 37.376 7.68t30.72 20.48 20.48 30.72 7.68 37.376q0 20.48-7.68 37.888t-20.48 30.208-30.72 20.48-37.376 7.68l-287.744 0 0 287.744q0 20.48-7.68 37.888t-20.48 30.208-30.72 20.48-37.376 7.68q-20.48 0-37.888-7.68t-30.208-20.48-20.48-30.208-7.68-37.888l0-287.744-287.744 0q-20.48 0-37.888-7.68t-30.208-20.48-20.48-30.208-7.68-37.888q0-19.456 7.68-37.376t20.48-30.72 30.208-20.48 37.888-7.68l287.744 0 0-287.744q0-19.456 7.68-37.376t20.48-30.72 30.208-20.48 37.888-7.68q39.936 0 68.096 28.16t28.16 68.096l0 287.744 287.744 0z" p-id="2198"></path></svg>
        </el-icon>
        &nbsp;添加商品
      </el-button>
      <!-- 导出数据 -->
      <el-button type="warning" @click="export2Table">
        <el-icon>
          <svg t="1647313957290" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2289" width="200" height="200"><path d="M395.9 406H288.5c-2.8 0-5.7-0.7-8.1-2.4-18.4-13.1-18.2-34.3-6.4-46.3l217.6-220.9c11.1-11.2 29.2-11.4 40.4-0.3l0.3 0.3 217.7 221c11.1 11.3 10.9 29.4-0.4 40.4-5.3 5.2-12.5 8.2-19.9 8.2H628.1v215.7c0 7.9-6.4 14.3-14.3 14.3H410.2c-7.9 0-14.3-6.4-14.3-14.3V406zM283.3 652.4v87.5c0 7.9 6.4 14.3 14.3 14.3h428.8c7.9 0 14.3-6.4 14.3-14.3v-87.5c0-7.9 6.4-14.3 14.3-14.3h142.9c7.9 0 14.3 6.4 14.3 14.3V914c0 7.9-6.4 14.3-14.3 14.3H126.1c-7.9 0-14.3-6.4-14.3-14.3V652.4c0-7.9 6.4-14.3 14.3-14.3H269c7.9 0 14.3 6.4 14.3 14.3z" p-id="2290"></path></svg>
        </el-icon>
        &nbsp;导出数据
      </el-button>
      <el-button type="primary" @click="transferCommodity">调货</el-button>
      <el-select placeholder="批量操作" style="width: 110px;margin-left: 12px; position: relative; top: 2px;">
        <el-option @click="deleteCommodityList">
          <span style="float: left;">
            <el-icon><delete /></el-icon>
          </span>
          <span style="padding-left: 6px; position: relative; top: -2px;">删除</span>
        </el-option>
      </el-select>
    </div>
  </div>

  <!-- 表格 -->
  <el-table ref="multipleTableRef" :data="commodityPageList" @selection-change="handleSelectionChange" style="width: 100%; margin-top: 10px;" table-layout="auto" size="large" border stripe>
    <el-table-column type="selection" width="55" />
    <el-table-column label="商品图片">
      <template #default="props">
          <el-image style="width: 60px; height: 60px" :src="WAREHOUSE_CONTEXT_PATH + props.row.imgs" fit="fill" />
      </template>
    </el-table-column>
    <el-table-column prop="productName" label="商品名称" sortable />
    <el-table-column prop="brandName" label="品牌" sortable />
    <el-table-column prop="typeName" label="类型" sortable />
    <el-table-column prop="supplyName" label="供应商" sortable />
    <el-table-column prop="placeName" label="产地" sortable />
    <el-table-column prop="storeName" label="仓库" sortable />
    <el-table-column prop="productInvent" label="库存" sortable />
    <el-table-column label="上/下架" sortable>
      <template #default="props">
          <span>{{props.row.upDownState==0?"未上架":"已上架"}}</span>
      </template>
    </el-table-column>
    <el-table-column prop="salePrice" label="售价" sortable />
    <el-table-column prop="unitName" label="单位" sortable />
    <el-table-column prop="productDate" label="生产日期" sortable />
    <el-table-column prop="suppDate" label="保质期" sortable />
    <el-table-column label="操作" fixed="right" width="240">
      <template #default="props">
        <el-link type="primary" v-if="props.row.upDownState==0" @click.prevent="openCommodityUpdate(props.row)">修改</el-link>
        <el-link type="primary" v-if="props.row.upDownState==0" @click.prevent="deleteCommodity(props.row.productId)">删除</el-link>
        <el-link type="primary" v-if="props.row.upDownState==0" @click="changState(props.row.productId, 1)">上架</el-link>
        <el-link type="primary" v-if="props.row.upDownState==1" @click="changState(props.row.productId, 0)">下架</el-link>
        <el-link type="primary" @click.prevent="openPurchaseAdd(props.row)">采购</el-link>
        <el-link type="primary" v-if="props.row.upDownState==1" @click.prevent="openOutstoreAdd(props.row)">出库</el-link>
        <el-link type="primary">盘点</el-link>
      </template>
    </el-table-column>
  </el-table>
  <!-- 分页 -->
  <el-pagination
    background
    :total="params.totalNum"
    :page-sizes="[5, 10, 15, 20, 25, 30]"
    v-model:page-size="params.pageSize"
    v-model:currentPage="params.pageNum"
    layout="total, sizes, prev, pager, next, jumper"
    style="margin-top: 20px;"
    @size-change="changeSize"
    @current-change="changeCurrent"
  />

  <!-- 添加商品对话框 -->
  <commodity-add ref="commodityAddRef" @ok="getCommodityPageList"></commodity-add>
  
  <!-- 修改商品对话框 -->
  <commodity-update ref="commodityUpdateRef" @ok="getCommodityPageList"></commodity-update>

  <!-- 添加采购单对话框 -->
  <purchase-add ref="purchaseAddRef" @ok="toPurchaseList"></purchase-add>

  <!-- 添加出库单对话框 -->
  <outstore-add ref="outstoreAddRef" @ok="toOutstoreList"></outstore-add>

</template>

<script setup>
import { reactive, ref } from 'vue';
import { get, put, del, tip, export2excel, WAREHOUSE_CONTEXT_PATH } from "@/common";
import { useRouter } from "vue-router";
import { Search, Edit, Check, Message, Star, Delete } from '@element-plus/icons-vue'

const router = useRouter(); // 获取路由器

// 分页模糊查询数据
const params = reactive({
  storeId: 1,
  productName: '',
  brandName: '',
  typeName: '',
  supplyName: '',
  placeName: '',
  upDownState: '',
  isOverDate: '',
  pageSize: 5,
  pageNum: 1,
  totalNum: 0
})

// 表格数据
const commodityPageList = ref();

// 获取分页模糊查询结果
const getCommodityPageList = () => {
  get("/product/product-page-list", params).then(result => {
    commodityPageList.value = result.data.resultList;
    params.totalNum = result.data.totalNum;
  });
}
getCommodityPageList();

// 所有仓库
const storeList = ref();
// 获取所有仓库
const getStoreList = () => {
  get("/product/store-list").then(result => {
    storeList.value = result.data;
  });
}
getStoreList();

// 所有品牌
const brandList = ref();
// 获取所有品牌
const getBrandList = () => {
  get("/product/brand-list").then(result => {
    brandList.value = result.data;
  });
}
getBrandList();

// 所有分类-分层结构
const categoryTree = ref();
// 获取所有分类
const getCategoryTree = () => {
  get("/product/category-tree").then(result => {
    categoryTree.value = result.data;
  });
}
getCategoryTree();

// 所有供应商
const supplyList = ref();
// 获取所有供应商
const getSupplyList = () => {
  get("/product/supply-list").then(result => {
    supplyList.value = result.data;
  });
}
getSupplyList();

// 所有产地
const placeList = ref();
// 获取所有产地
const getPlaceList = () => {
  get("/product/place-list").then(result => {
    placeList.value = result.data;
  });
}
getPlaceList();

// 所有单位
const unitList = ref();
// 获取所有单位
const getUnitList = () => {
  get("/product/unit-list").then(result => {
    unitList.value = result.data;
  });
}
getUnitList();

// 复选框的操作
const multipleTableRef = ref();
const multipleSelection = ref([]);
const toggleSelection = (rows) => {
  if (rows) {
    rows.forEach((row) => {
      multipleTableRef.value.toggleRowSelection(row, undefined)
    })
  } else {
    multipleTableRef.value.clearSelection()
  }
}
const handleSelectionChange = (val) => {
  multipleSelection.value = val;
}

// 导出数据
const export2Table = () => {
  get("/product/exportTable", params).then(result => {
    // 要导出的数据
    const productList = result.data;
    // 将upDownState字段的0、1转化为是否上架
    productList.reduce((pre, cur) => {
      cur.upDownState = cur.upDownState==0?"未上架":"已上架";
      return pre;
    }, []);
    const columns = [
      {"title": "商品ID", "key": "productId"},
      {"title": "商品名称", "key": "productName"},
      {"title": "品牌", "key": "brandName"},
      {"title": "类型", "key": "typeName"},
      {"title": "供应商", "key": "supplyName"},
      {"title": "产地", "key": "placeName"},
      {"title": "仓库", "key": "storeName"},
      {"title": "库存", "key": "productInvent"},
      {"title": "上/架", "key": "upDownState"},
      {"title": "售价", "key": "salePrice"},
      {"title": "单位", "key": "unitName"},
      {"title": "生产日期", "key": "productDate"},
      {"title": "保质期", "key": "suppDate"},
    ];
    export2excel(columns, productList, "商品信息表");
  });
}

// 调货
const transferCommodity = () => {
  // 通过路由导航到调货列表页面
  router.push({ path: "/transshipment/transfer", query: {"storeId": params.storeId } });
}

// 跳向添加商品
import CommodityAdd from "./commodity-add.vue";
const commodityAddRef = ref();
const openCommodityAdd = () => {
  commodityAddRef.value.open(storeList, brandList, categoryTree, supplyList, placeList, unitList);
};


// 跳向修改商品
import CommodityUpdate from "./commodity-update.vue";
const commodityUpdateRef = ref();
const openCommodityUpdate = (commodity) => {
  commodityUpdateRef.value.open(commodity, storeList, brandList, categoryTree, supplyList, placeList, unitList);
};

// 跳向修改采购单
import PurchaseAdd from "../../purchase/purchase-add.vue";
const purchaseAddRef = ref();
const openPurchaseAdd = (commodity) => {
  purchaseAddRef.value.open(commodity);
};

// 跳向添加出库单
import OutstoreAdd from "../../outstore/outstore-add.vue";
const outstoreAddRef = ref();
const openOutstoreAdd = (commodity) => {
  outstoreAddRef.value.open(commodity);
};

// 跳转到采购单列表页面
const toPurchaseList = (storeId) => {
  // 通过路由导航到采购单列表页面
  router.push({ path: "/purchase/index", query: {"storeId": storeId } });
}

// 跳转到出库单列表页面
const toOutstoreList = (storeId) => {
  // 通过路由导航到出库单列表页面
  router.push({ path: "/outstore/index", query: {"storeId": storeId } });
}

// 删除单个商品
const deleteCommodity = (productId) => {
  del(`/product/product-delete/${productId}`, null, { title: "提示", message: "您确定删除该商品吗？" }).then(result => {
    tip.success(result.message);
    // 重新查询
    getCommodityPageList();
  });
}

// 批量删除
const deleteCommodityList = () => {
  if(multipleSelection.value.length){
    // 取出所有选中的id
    const productIds = multipleSelection.value.reduce((prev, cur) =>{
      prev.push(cur.productId);
      return prev;
    }, []);

    del(`/product/product-list-delete`, productIds, { title: "提示", message: "您确定删除选中商品吗？" }).then(result => {
      tip.success(result.message);
      // 重新查询
      getCommodityPageList();
    });
  }else{
    tip.error("请选择需要删除的行！");
  }
}

// 上/下架
const changState = (productId, upDownState) => {
  put(`/product/state-change`, {productId, upDownState}).then(result => {
    tip.success(result.message);
    // 重新查询
    getCommodityPageList();
  });
}

// 品牌模糊查询框的联想输入
const brandSearch = (queryString, callback) => {
  const results = queryString
    ? brandList.value.filter(createFilter(queryString))
    : brandList.value
  // 回调方法，返回联想的数据
  callback(results);
}

const createFilter = (queryString) => {
  return (brand) => {
    return brand.brandName.indexOf(queryString) != -1;
  }
}

// 修改每页显示条数
const changeSize = (size) => {
  params.pageSize = size;
  // 重新查询
  getCommodityPageList();
}
// 修改当前页码
const changeCurrent = (num) => {
  params.pageNum = num;
  // 重新查询
  getCommodityPageList();
}
</script>

<style scoped>
.searchForm{
  margin-top: 20px;
  display: flex;
}
.el-link {
  margin-right: 8px;
}
</style>