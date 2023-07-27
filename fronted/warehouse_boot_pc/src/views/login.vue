<template>
  <div class="login">
    <el-card class="box-card" shadow="always">
      <div
        style="
          padding: 40px 0px 60px 0px;
          text-align: center;
          color: #409eff;
          font-size: 50px;
          font-weight: bold;
          letter-spacing: 3px;
        "
      >恒合仓库管理系统
      </div>
      <el-form
        ref="loginForm"
        :model="loginUser"
        :rules="rules"
        size="large"
        label-position="right"
        label-width="70px"
        style="width: 360px; margin: 0px auto"
      >
        <el-form-item label="账号" prop="userCode">
          <el-input v-model="loginUser.userCode"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="userPwd">
          <el-input type="password" v-model="loginUser.userPwd" show-password></el-input>
        </el-form-item>
        <el-form-item label="验证码" prop="verificationCode">
          <el-input v-model="loginUser.verificationCode">
            <template #suffix>
              <el-image
                style="overflow: visible; position: relative; left: 16px;"
                :src="codeSrc"
                @click="codeSrc=codeSrc+'?'+new Date()"
                ></el-image>
            </template>
          </el-input>
        </el-form-item>
      </el-form>
      <div style="text-align: right; width: 360px; margin: 40px auto 0px">
        <el-button
          @click="login"
          type="primary"
          size="large"
          style="width: 300px"
          >登录</el-button>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import { useRouter } from "vue-router";
import { post, tip, setLocalToken, WAREHOUSE_CONTEXT_PATH } from "@/common";

const loginForm = ref();

const router = useRouter(); // 获取路由器

const loginUser = reactive({ 
  userCode: "admin", 
  userPwd: "123456",
  verificationCode: ""
});

// 验证码后台接口
const codeSrc = ref(WAREHOUSE_CONTEXT_PATH + "/captcha/captchaImage");

const rules = reactive({
  userCode: [
    {
      required: true,
      message: "请输入账号！",
      trigger: "blur"
    },
  ],
  userPwd: [
    {
      required: true,
      message: "请输入密码！",
      trigger: "blur"
    },
  ],
  verificationCode: [
    {
      min: 4,
      max: 4,
      required: true,
      message: "请输入正确的验证码！",
      trigger: "blur"
    }
  ]
});

// 回车登录
window.onkeydown = ($event) => {
  if($event.key && $event.key == 'Enter'){
    login();
  }
}

const login = () => {
  loginForm.value.validate((valid) => {
    if (valid) {
      // 向服务端发出post请求
      post("/login", loginUser).then((result) => {
        // 从回送结果中取出令牌，并将令牌存于客户端
        setLocalToken(result.data);
        tip.success("登录成功！");
        // 通过路由导航到home页面
        router.push({ path: "/home" });
      });
    }
  });
};
</script>


<style scoped>
.login {
  background-image: url("/login.jpg");
  background-size: 100% 100%;

  position: fixed;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;

  display: flex;
  justify-content: center;
  align-items: center;
}
.box-card {
  width: 800px;
  height: 500px;
  opacity: 0.92;
}
</style>
