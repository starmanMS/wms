<template>
  <div
    style="width: 100%; font-size: 80px; text-align: center; margin-top: 100px"
  >
    路由<span v-if="$route.query && $route.query.toPath" style="color:red;">&nbsp;{{$route.query.toPath}}&nbsp;</span>不存在！
  </div>
</template>