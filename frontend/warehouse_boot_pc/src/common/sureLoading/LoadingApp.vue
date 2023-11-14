<template>
  <transition name="bounce">
    <div
      v-if="sureLoading.loading"
      style="
        z-index: 9000;
        position: fixed;
        left: 0px;
        right: 0px;
        top: 0px;
        bottom: 0px;
      "
    >
      <div
        style="
          position: absolute;
          left: 0px;
          right: 0px;
          top: 0px;
          bottom: 0px;
          background-color: rgba(255, 255, 255, 0.7);
        "
      ></div>

      <div class="spinner">
        <div class="ani">
          <div class="bounce1"></div>
          <div class="bounce2"></div>
          <div class="bounce3"></div>
        </div>
        <span v-if="sureLoading.tip" style="margin-top: 10px; color: #53a8ff">{{
          sureLoading.tip
        }}</span>
      </div>
    </div>
  </transition>
</template>




<script>
import { sureLoading } from "./index";
export default {
  setup(props) {
    return {
      sureLoading,
    };
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
    opacity: 0;
  }

  100% {
    opacity: 1;
  }
}

.spinner {
  position: absolute;
  top: 0px;
  left: 0px;
  bottom: 0px;
  right: 0px;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.spinner > .ani {
  display: flex;
}

.spinner > .ani > div {
  width: 30px;
  height: 30px;
  background-color: #53a8ff;

  border-radius: 50%;

  animation: bouncedelay 2s infinite ease-in-out;
  /* Prevent first frame from flickering when animation starts */
  animation-fill-mode: both;
}

.spinner > .ani > .bounce1 {
  animation-delay: -0.7s;
}

.spinner > .ani > .bounce2 {
  animation-delay: -0.35s;
}

@keyframes bouncedelay {
  0%,
  80%,
  100% {
    transform: scale(0);
  }

  40% {
    transform: scale(1);
  }
}
</style>