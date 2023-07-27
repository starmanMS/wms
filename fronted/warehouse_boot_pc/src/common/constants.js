/**
 * 常量定义
 * 作者：王坤 2022-03
 */
export const VERSION = import.meta.env.VITE_VERSION;
export const BASE_URL = import.meta.env.BASE_URL;
export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
export const LOCAL_TOKEN = import.meta.env.VITE_LOCAL_TOKEN; // 本地存储TOKEN的名字
export const HEADER_TOKEN = import.meta.env.VITE_HEADER_TOKEN; // 请求头上TOKEN的名字
export const LOGIN_ROUTE_NAME = import.meta.env.VITE_LOGIN_ROUTE_NAME; // 登录路由名称
export const WAREHOUSE_CONTEXT_PATH = import.meta.env.VITE_WAREHOUSE_CONTEXT_PATH; // 后台地址的上下文路径


export default {
    install(app) {
        app.config.globalProperties.$version = VERSION;
        app.config.globalProperties.$baseUrl = BASE_URL;
        app.config.globalProperties.$apiBaseUrl = API_BASE_URL;
    }
}