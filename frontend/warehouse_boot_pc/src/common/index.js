/**
 * common统一对外接口
 * 作者：王坤 2022-03
 */

export { VERSION, BASE_URL, API_BASE_URL, WAREHOUSE_CONTEXT_PATH } from './constants'
export { get, post, del, put, postFormData, getBlob } from './request'
export { ElMessage as tip , ElMessage } from 'element-plus'
export { getLocalToken, setLocalToken, removeLocalToken } from './token'
export { debounce, debounceInstance1, debounceInstance2, debounceInstance3, throttle, throttleInstance1, throttleInstance2, throttleInstance3 } from './debounce'
export { sureLoading } from './sureLoading'
export { default as ddo } from './ddo'
export { dateFormat } from './date'
export { export2excel } from './excel'


/*

    常量：
       VERSION 项目版本号
       BASE_URL 基础路径
       API_BASE_URL 服务端基础路径

    请求方法：
        get post del(delete请求) put postFormData getBlob
    
    tip 提示工具

    本地token(令牌)操作
        getLocalToken 获取本地token
        setLocalToken 存储本地token
        removeLocalToken 删除本地token

    sureLoading 加载提示

    ddo 数据字典

    date Date的扩展


*/