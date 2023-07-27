<template>
  <!-- 分配角色对话框 -->
  <el-dialog v-model="visible" title="分配角色" width="25%">
    <el-form ref="userAssignRoleRef" :model="userAssignRole" label-position="top">
      <el-form-item label="用户名：">
        <el-input v-model="userAssignRole.userCode" autocomplete="off" disabled />
      </el-form-item>
      <el-form-item label="角色：">
        <!-- 功能：将用户已有角色默认选中 -->
        <!-- 方法1：v-model绑定boolean数组 -->
        <!-- <el-checkbox v-for="role,idx of roleList" v-model="chk[idx]" :label="role.roleName" :key="role.roleId" /> -->
        <!-- 方法2：将lable属性需要默认选中的数据放入roleCheckList中 -->
        <el-checkbox-group v-model="userAssignRole.roleCheckList">
          <el-checkbox v-for="role of userAssignRole.roleList" :label="role.roleName" :key="role.roleId" />
        </el-checkbox-group>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="visible=false">取消</el-button>
        <el-button type="primary" @click="assignRole">确认修改</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { get, put, tip } from "@/common";

const visible = ref(false); // 该页面的可见性
const userRoleList = ref([]); // 用户的角色列表

// 该对话框打开并初始化
const open = (user, roleList) => {
  userAssignRole.userId = user.userId;
  userAssignRole.userCode = user.userCode;
  userAssignRole.roleList = roleList;
  visible.value = true;
  // 获取被分配角色用户的已有角色
  get(`/user/user-role-list/${user.userId}`).then(result => {
    userRoleList.value = result.data;
    checkedUserRole(); // 如果用户有该角色，则默认选中
  });
};

// 分配角色对象
const userAssignRole = reactive({
  userId: '',
  userCode: '',
  roleList: [],
  roleCheckList: []
});

const chk = ref([]); // 用户是否有该角色
// 判断某角色是不是用户的已有角色
const checkedUserRole = () => {
  // 方法1
  /* chk.value = roleList.value.reduce((pre, cur) => {
    let b = false; // 当前角色(cur.roleId)是否包含在用户角色列表中
    // 遍历当前用户角色列表，判断有没有当前角色(cur.roleId)
    userRoleList.value.forEach(role => {
      if(cur.roleId==role.roleId) b = true;
    });
    pre.push(b);
    return pre;
  }, []); */
  // 方法2 将用户已有的角色名放入roleCheckList
  userAssignRole.roleCheckList = userRoleList.value.reduce((pre, cur) => {
    pre.push(cur.roleName);
    return pre;
  }, []);
}

const userAssignRoleRef = ref();
// 分配角色提交
const assignRole = () => {
  userAssignRoleRef.value.validate(valid => {
    if(valid){
      // put('/user/assignRole', userAssignRole, { title: "提示", message: "您确定重新分配角色吗？" })
      put('/user/assignRole', userAssignRole).then(result => {
        tip.success(result.message);
        visible.value = false;
      });
    }
  });
}

defineExpose({ open });
</script>
<style scoped>

</style>