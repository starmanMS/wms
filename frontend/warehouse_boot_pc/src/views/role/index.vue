<template>
    <!-- <h2>角色列表</h2>
    <el-divider></el-divider> -->
    <div>
      <el-form class="searchForm">
        <el-form-item label="角色名:">
          <el-input v-model="params.roleName" placeholder="角色名" style="width: 120px;"  clearable></el-input>
        </el-form-item>
        <el-form-item label="角色代码:" style="margin-left: 30px;">
          <el-input v-model="params.roleCode" placeholder="角色代码" style="width: 120px;"  clearable></el-input>
        </el-form-item>
        <el-form-item label="角色状态:" style="margin-left: 30px;">
          <el-select v-model="params.roleState" placeholder="角色状态" style="width: 120px;" clearable>
            <el-option label="禁用" value="0"></el-option>
            <el-option label="启用" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item style="margin-left: 30px;">
          <el-button type="primary" @click="getRoleList" style="margin-left: 10px;">
            <el-icon>
              <svg t="1646977561352" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3057" width="200" height="200"><path d="M986.304 871.424L747.328 630.4c-2.816-2.752-5.888-4.928-8.768-7.232 40.32-62.464 63.936-136.832 63.936-216.96 0-220.16-176.96-398.592-395.392-398.592C188.8 7.616 11.712 186.048 11.712 406.208s177.088 398.592 395.392 398.592a391.232 391.232 0 0 0 215.36-64.576c2.24 3.072 4.352 6.08 7.04 8.832l239.04 241.024a82.688 82.688 0 0 0 117.76 0 84.48 84.48 0 0 0 0-118.656m-579.2-192.512c-149.12 0-270.528-122.368-270.528-272.704 0-150.4 121.344-272.768 270.528-272.768 149.12 0 270.528 122.432 270.528 272.768 0 150.4-121.408 272.704-270.528 272.704" p-id="3058"></path></svg>
            </el-icon>
            &nbsp;查&nbsp;&nbsp;询
          </el-button>
        </el-form-item>
      </el-form>
      <div>
        <el-button type="primary" @click="openRoleAdd()">
          <el-icon>
            <svg t="1646977404025" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2197" width="200" height="200"><path d="M925.696 384q19.456 0 37.376 7.68t30.72 20.48 20.48 30.72 7.68 37.376q0 20.48-7.68 37.888t-20.48 30.208-30.72 20.48-37.376 7.68l-287.744 0 0 287.744q0 20.48-7.68 37.888t-20.48 30.208-30.72 20.48-37.376 7.68q-20.48 0-37.888-7.68t-30.208-20.48-20.48-30.208-7.68-37.888l0-287.744-287.744 0q-20.48 0-37.888-7.68t-30.208-20.48-20.48-30.208-7.68-37.888q0-19.456 7.68-37.376t20.48-30.72 30.208-20.48 37.888-7.68l287.744 0 0-287.744q0-19.456 7.68-37.376t20.48-30.72 30.208-20.48 37.888-7.68q39.936 0 68.096 28.16t28.16 68.096l0 287.744 287.744 0z" p-id="2198"></path></svg>
          </el-icon>
          &nbsp;添加角色
        </el-button>
        <!-- 导出数据 -->
        <el-button type="warning" @click="export2Table">
          <el-icon>
            <svg t="1647313957290" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2289" width="200" height="200"><path d="M395.9 406H288.5c-2.8 0-5.7-0.7-8.1-2.4-18.4-13.1-18.2-34.3-6.4-46.3l217.6-220.9c11.1-11.2 29.2-11.4 40.4-0.3l0.3 0.3 217.7 221c11.1 11.3 10.9 29.4-0.4 40.4-5.3 5.2-12.5 8.2-19.9 8.2H628.1v215.7c0 7.9-6.4 14.3-14.3 14.3H410.2c-7.9 0-14.3-6.4-14.3-14.3V406zM283.3 652.4v87.5c0 7.9 6.4 14.3 14.3 14.3h428.8c7.9 0 14.3-6.4 14.3-14.3v-87.5c0-7.9 6.4-14.3 14.3-14.3h142.9c7.9 0 14.3 6.4 14.3 14.3V914c0 7.9-6.4 14.3-14.3 14.3H126.1c-7.9 0-14.3-6.4-14.3-14.3V652.4c0-7.9 6.4-14.3 14.3-14.3H269c7.9 0 14.3 6.4 14.3 14.3z" p-id="2290"></path></svg>
          </el-icon>
          &nbsp;导出数据
        </el-button>
      </div>
    </div>
    <!-- 表格 -->
    <el-table :data="rolePageList" style="width: 100%; margin-top: 10px;" table-layout="auto" size="large" border stripe>
      <el-table-column prop="roleId" label="角色ID" sortable />
      <el-table-column prop="roleName" label="角色名" sortable />
      <el-table-column prop="roleDesc" label="角色描述" />
      <el-table-column prop="roleCode" label="角色代码" sortable />
      <el-table-column label="状态" sortable>
        <template #default="props">
            <span :class="{red:props.row.roleState=='0'}">{{props.row.roleState=="0"?"禁用":"启用"}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="getCode" label="创建人" sortable />
      <el-table-column prop="createTime" label="创建时间" sortable />
      <el-table-column label="操作">
        <template #default="props">
          <el-button type="primary" title="修改角色" :icon="Edit" circle @click="openRoleUpdate(props.row)" />
          <el-button type="danger" title="删除角色" :icon="Delete" circle @click="deleteRole(props.row.roleId)" />
          <el-button type="warning" @click="updateState(props.row)">{{props.row.roleState=="1"?"禁用":"启用"}}</el-button>
          <el-button type="primary" v-if="props.row.roleState==1" @click="openUpdateAuth(props.row)">更改权限</el-button>
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

    <!-- 添加角色对话框 -->
    <role-add ref="roleAddRef" @ok="getRoleList"></role-add>

    <!-- 修改角色对话框 -->
    <role-update ref="roleUpdateRef" @ok="getRoleList"></role-update>

</template>

<script setup>
import { reactive, ref, computed } from 'vue';
import { useRouter } from 'vue-router'
import { get, put, del, tip, export2excel } from "@/common";
import { Search, Edit, Check, Message, Star, Delete } from '@element-plus/icons-vue'

const router = useRouter(); // 获取路由器

// 分页模糊查询数据
const params = reactive({
  roleName: '',
  roleCode: '',
  roleState: '',
  pageSize: 5,
  pageNum: 1,
  totalNum: 0
})

// 表格数据
const rolePageList = ref();

// 获取分页模糊查询结果
const getRoleList = () => {
  get("/role/role-page-list", params).then(result => {
    rolePageList.value = result.data.resultList;
    params.totalNum = result.data.totalNum;
  });
}
getRoleList();

// 导出数据
const export2Table = () => {
  get("/role/exportTable", params).then(result => {
    // 要导出的数据
    const roleList = result.data;
    const columns = [
      {"title": "角色ID", "key": "roleId"},
      {"title": "角色名", "key": "roleName"},
      {"title": "角色描述", "key": "roleDesc"},
      {"title": "角色代码", "key": "roleCode"},
      {"title": "用户状态", "key": "roleState"},
      {"title": "创建人", "key": "getCode"},
      {"title": "创建时间", "key": "createTime"}
    ];
    export2excel(columns, roleList, "角色信息表");
  });
}

// 添加角色
import RoleAdd from "./role-add.vue";
const roleAddRef = ref();
const openRoleAdd = () => {
  roleAddRef.value.open();
};

// 修改角色
import RoleUpdate from "./role-update.vue";
const roleUpdateRef = ref();
const openRoleUpdate = (row) => {
  roleUpdateRef.value.open(row);
};

// 删除角色
const deleteRole = (roleId) => {
  del(`/role/role-delete/${roleId}`, null, { title: "提示", message: "您确定删除该角色吗？" }).then(result => {
    tip.success(result.message);
    // 重新查询
    getRoleList();
  });
}

// 修改角色状态
const updateState = (role) => {
  role.roleState = role.roleState=="0"?"1":"0";
  put('/role/role-state-update', role).then(result => {
    // 重新查询
    getRoleList();
  });
}

// 点击修改权限
const openUpdateAuth = (role) => {
  // 通过路由导航到修改权限页面
  // path不可以和params搭档，否则params会失效
  router.push({ path: '/role/auth-update', query: {"roleId": role.roleId } });
};

// 修改每页显示条数
const changeSize = (size) => {
  params.pageSize = size;
  // 重新查询
  getRoleList();
}
// 修改当前页码
const changeCurrent = (num) => {
  params.pageNum = num;
  // 重新查询
  getRoleList();
}

</script>
<style scoped>
.searchForm{
  display: flex;
}
.red{
  color: red;
}
</style>