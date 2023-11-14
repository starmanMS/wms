import { createApp } from 'vue'

import 'font-awesome/css/font-awesome.min.css'

import constants from '@/common/constants'

import router from '@/common/router'

// excel导出
import excel from "@/common/excel"

// 导入已封装好的服务端访问对象
import request from "@/common/request"

// 导入防抖函数
import debounce from "@/common/debounce"

// 导入快捷提示对象
import tip from "@/common/tip"

// 数据字典初始化
import "@/common/ddo"

// 加载提示组件初始化
import "@/common/sureLoading/loading"
// 导入加载提示
import loading from "@/common/sureLoading"

// 导入element-plus
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhCn from 'element-plus/es/locale/lang/zh-cn'

import App from './App.vue'


createApp(App).use(constants).use(router).use(excel).use(request).use(debounce).use(tip).use(loading).use(ElementPlus,{
    locale: zhCn,
  }).mount('#app');

