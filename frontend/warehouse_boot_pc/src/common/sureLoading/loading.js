/**
 * 加载提示
 * 作者：王坤 2022-03
 */

import { createApp } from 'vue';
import LoadingApp from './LoadingApp.vue'

const loadingApp = createApp(LoadingApp);
const loading_ = loadingApp.mount(document.createElement('div'));
document.body.appendChild(loading_.$el);