
<template>
  <template v-if="visible">
    <transition name="bounce">
      <div
        v-if="visible2"
        style="
          z-index: 10000;
          position: fixed;
          top: 0.3rem;
          left: 50%;
          margin-left: -1.7rem;
          width: 3rem;
          padding: 0.1rem 0.2rem;
          border-radius: 0.05rem;
        "
        :style="{
          color: color,
          backgroundColor: lightbg,
          border: '1px solid ' + bg,
          boxShadow: '0px 0px 1px 0px ' + bg,
        }"
      >
        <i class="fa fa-lg" :class="[icon]" style="margin-right: 0.05rem"></i>
        {{ title }}
      </div>
    </transition>
  </template>
</template>
<script>
const showTip = (vm) => {
  vm.visible = true;
  vm.$nextTick(() => {
    vm.visible2 = true;
  });
};
export default {
  data() {
    return {
      visible: false,
      visible2: false,
      status: "",
      title: "",
    };
  },

  computed: {
    icon() {
      switch (this.status) {
        case "success":
          return "fa-check-circle";
        case "error":
          return "fa-times-circle";
        case "info":
          return "fa-info-circle";
        case "warning":
          return "fa-exclamation-circle";
        case "404":
          return "fa-ban";
        case "403":
          return "fa-lock";
        case "500":
          return "fa-exclamation-triangle";
        default:
          return "fa-info-circle";
      }
    },
    color() {
      switch (this.status) {
        case "success":
          return "#67C23A";
        case "error":
        case "404":
        case "403":
        case "500":
          return "#F56C6C";
        case "info":
          return "#909399";
        case "warning":
          return "#E6A23C";
        default:
          return "#909399";
      }
    },
    bg() {
      switch (this.status) {
        case "success":
          return "#E1F3D8";
        case "error":
        case "404":
        case "403":
        case "500":
          return "#FDE2E2";
        case "info":
          return "#E9E9EB";
        case "warning":
          return "#FAECD8";
        default:
          return "#E9E9EB";
      }
    },
    lightbg() {
      switch (this.status) {
        case "success":
          return "#F0F9EB";
        case "error":
        case "404":
        case "403":
        case "500":
          return "#FEF0F0";
        case "info":
          return "#F4F4F5";
        case "warning":
          return "#FDF6EC";
        default:
          return "#F4F4F5";
      }
    },
  },

  methods: {
    show(options) {
      return new Promise((resolve) => {
        const { status, title, duration } = options || {};
        this.status = status || "info";
        this.title = title || "无信息";
        showTip(this);
        if (duration === 0) return;

        setTimeout(() => {
          resolve();
          this.close();
        }, duration || 2000);
      });
    },

    success(options) {
      if (typeof options === "string") {
        return this.show({
          status: "success",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "success",
          title: title || "操作成功！",
          duration,
        });
      }
    },
    error(options) {
      if (typeof options === "string") {
        return this.show({
          status: "error",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "error",
          title: title || "操作失败！",
          duration,
        });
      }
    },
    info(options) {
      if (typeof options === "string") {
        return this.show({
          status: "info",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "info",
          title: title || "提示信息！",
          duration,
        });
      }
    },
    warn(options) {
      if (typeof options === "string") {
        return this.show({
          status: "warning",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "warning",
          title: title || "警示信息！",
          duration,
        });
      }
    },
    err_404(options) {
      if (typeof options === "string") {
        return this.show({
          status: "404",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "404",
          title: title || "资源不存在！",
          duration,
        });
      }
    },
    err_403(options) {
      if (typeof options === "string") {
        return this.show({
          status: "403",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "403",
          title: title || "无访问授权！",
          duration,
        });
      }
    },
    err_500(options) {
      if (typeof options === "string") {
        return this.show({
          status: "500",
          title: options,
        });
      } else {
        const { title, duration } = options || {};
        return this.show({
          status: "500",
          title: title || "服务器错误！",
          duration,
        });
      }
    },

    close() {
      this.visible2 = false;
      setTimeout(() => {
        this.visible = false;
      }, 500);
    },
  },
};
</script>
<style scoped>
.bounce-enter-active {
  animation: bounce-in 0.5s;
}
.bounce-leave-active {
  animation: bounce-in 0.5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
    top: 0px;
    opacity: 0;
  }

  10% {
    transform: scale(0.8);
    opacity: 0.3;
  }

  100% {
    transform: scale(1);
    top: 30px;
    opacity: 1;
  }
}
</style>