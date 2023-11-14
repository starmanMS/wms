/**
 * 封装请求组件
 * 作者：王坤 2022-03
 */

import axios from "axios";
import router from '../router'
import message from './request-message';


import {
	API_BASE_URL, HEADER_TOKEN, LOGIN_ROUTE_NAME
} from '../constants'
import {
	getLocalToken,
	removeLocalToken
} from '../token'

import { sureLoading } from "../sureLoading"



// 请求信息数组（池），请求发出时放入请求池，请求响应时从请求池清除
class RequestInfoPool {

	constructor() {
		console.log('创建了请求信息池，timestamp：' + new Date().getTime());
	}

	pool = []

	eq = (req1, req2) => {
		const r =
			req1.url === req2.url &&
			req1.method === req2.method &&
			req1.data === req2.data &&
			req1.params === req2.params

		return r;
	}

	obj2String = (obj) => {

		if (!obj) return obj;
		if (typeof obj === 'string' || obj instanceof String) obj = eval("(" + obj + ")")
		const r = {};
		for (let prop in obj) {
			r['"' + prop + '"'] = obj[prop];
		}

		return JSON.stringify(r);
	}

	/**
	 * 处理请求信息，如果请求信息池中不存在相同的请求信息，则将请求信息放入请求信息池中, 并返回true,否则发返回false
	 */
	putRequstInfo = (requestConfig, maxDuration = 5000) => {
		const {
			url,
			method,
			data
			//params
		} = requestConfig;

		const requestMethod = requestConfig.requestMethod;
		const initialData = requestConfig.initialData;


		//缓存中的请求不需要事件戳参数，因此将get请求中的时间戳参数去除
		let params = requestConfig.params;
		if (!method || method.toLowerCase() === 'get') {
			params = params ? { ...params } : {};
			params['_t'] && delete params['_t'];
		}

		const requestInfo = {
			req: {
				url: url,
				method: method,
				data: requestMethod == 'postFormData' ? this.obj2String(initialData) : this.obj2String(data),
				params: this.obj2String(params)
			},
			timestamp: new Date().getTime()
		};



		const oldRequestInfo = this.pool.find(info => this.eq(info.req, requestInfo.req));


		if (!oldRequestInfo) {
			this.pool.push(requestInfo);
			return true;
		}
		// //如果老的相同请求在maxDuration毫秒内没有结束，则清除老的请求信息放入新的请求信息
		// if(requestInfo.timestamp - oldRequestInfo.timestamp > maxDuration ){
		// 	this.removeRequestInfo(requestConfig);
		// 	this.pool.push(requestInfo);
		// 	return true;
		// }
		return false;
	}

	/**
	 * 删除指定的请求信息
	 */
	removeRequestInfo = (requestConfig) => {

		const {
			url,
			method,
			data,
			//params
		} = requestConfig;

		const requestMethod = requestConfig.requestMethod;
		const initialData = requestConfig.initialData;

		//缓存中的请求不需要事件戳参数，因此将get请求中的时间戳参数去除
		let params = requestConfig.params;
		if (!method || method.toLowerCase() === 'get') {
			params = params ? { ...params } : {};
			params['_t'] && delete params['_t'];
		}


		const requestInfo = {
			req: {
				url: url,
				method: method,
				data: requestMethod == 'postFormData' ? this.obj2String(initialData) : this.obj2String(data),
				params: this.obj2String(params)
			},
			timestamp: new Date().getTime()
		};

		const idx = this.pool.findIndex(info => this.eq(info.req, requestInfo.req));
		if (idx >= 0) {
			this.pool.splice(idx, 1);
		}
	}
	/**
		 * 删除所有的请求信息
		 */
	removeAllRequestInfo = () => {
		this.pool.splice(0, this.pool.length);
	}

	/**
	 * 请求信息池为是否为空
	 */
	isEmpty = () => this.pool.length === 0

	/**
	 * 请求信息池为是否仅有一个请求信息
	 */
	hasOnlyOne = () => this.pool.length === 1

}

//正在显示loading的请求数量
const loadingCount = {
	count: 0
};

//创建请求信息池
const requestInfoPool = new RequestInfoPool();


//HTTP状态和业务状态定义
const [
	HTTP_200,
	HTTP_201,
	HTTP_204,
	HTTP_400,
	HTTP_401,
	HTTP_403,
	HTTP_404,
	HTTP_500,
	CODE_SUCCESS_200,
	CODE_SUCCESS_0,
	CODE_201,
	CODE_204,
	CODE_400,
	CODE_401,
	CODE_403,
	CODE_404,
	CODE_500,
	CODE_510,
	CODE_INVALID_TOKEN,
	CODE_SYS_ERROR
] = [200, 201, 204, 400, 401, 403, 404, 500, 200, 0, 201, 204, 400, 401, 403, 404, 500, 510, 520, 530];

// HTTP状态含义
const HTTP_MAP = {
	[HTTP_200]: "请求成功返回内容",
	[HTTP_201]: "请求成功创建资源",
	[HTTP_204]: "请求成功无返回内容",
	[HTTP_400]: "请求数据错误",
	[HTTP_401]: "没有授权请登录",
	[HTTP_403]: "拒绝访问",
	[HTTP_404]: "资源不存在",
	[HTTP_500]: "服务内部错误",
};

// 业务状态含义
const CODE_MAP = {
	[CODE_SUCCESS_200]: "操作成功",
	[CODE_500]: "操作失败",
	[CODE_510]: "无访问授权",
	[CODE_INVALID_TOKEN]: "身份令牌失效或者账号异地登录",
	[CODE_SYS_ERROR]: "系统错误，请与管理员联系",
	[CODE_SUCCESS_0]: "操作成功",
	[CODE_201]: "请求成功创建资源",
	[CODE_204]: "请求成功无返回内容",
	[CODE_400]: "请求数据错误",
	[CODE_401]: "没有授权请登录",
	[CODE_403]: "拒绝访问",
	[CODE_404]: "资源不存在"

};



// 判断数据代码(code)或者状态(status)判断是否操作成功
const isSuccessful = (data) => {

	const successfulCodes = [CODE_SUCCESS_200, CODE_SUCCESS_0];

	if (typeof data.code === 'number') {
		return successfulCodes.indexOf(data.code) >= 0;
	}

	if (typeof data.status === 'number') {
		return successfulCodes.indexOf(data.status) >= 0;
	}

	return false;

};

// 获取数据代码(code)或者状态(status)的描述信息
const getCodeMessage = (data) => {

	if (data.message && data.message.trim()) {
		return data.message;
	}

	if (typeof data.code === 'number' && CODE_MAP[data.code]) {
		return CODE_MAP[data.code] + '(code:' + data.code + ')';
	}

	if (typeof data.code === 'number') {
		return '操作失败(code:' + data.code + ')！';
	}

	if (typeof data.status === 'number' && CODE_MAP[data.status]) {
		return CODE_MAP[data.status] + '(status:' + data.status + ')';
	}

	if (typeof data.status === 'number') {
		return '操作失败(status:' + data.status + ')！';
	}

	return '操作失败';
};

// 获取Http状态(status)的描述信息
const getHttpMessage = (httpStatusCode) => {



	if (typeof httpStatusCode === 'number' && HTTP_MAP[httpStatusCode]) {
		return HTTP_MAP[httpStatusCode] + '(HTTP状态码:' + httpStatusCode + ')';
	}

	// if(typeof httpStatusCode === 'number'){
	// 	return  '响应错误(代码'+httpStatusCode+')！';
	// }	

	return '响应错误(HTTP状态码:' + httpStatusCode + ')';
};



const getToken = () => getLocalToken();

// 获得取消令牌工厂
const CancelToken = axios.CancelToken;

let hide;

const instance = axios.create({
	baseURL: API_BASE_URL,
	headers: {
		'X-Requested-With': 'XMLHttpRequest'
	},
	// `timeout` 指定请求超时的毫秒数(0 表示无超时时间)
	// 如果请求话费了超过 `timeout` 的时间，请求将被中断  
	timeout: 10000,
});





instance.interceptors.request.use(

	function (config) {

		config = config || { loading: true, servMsg: false, servMsgSync: false };

		config.loading = config.loading !== false
		config.servMsg = config.servMsg === true // 是否显示服务端发来的成功消息
		config.servMsgSync = config.servMsgSync === true //服务端成功消息是否同步显示

		config['headers'][HEADER_TOKEN] = getToken(); // 请求时带上token

		const source = CancelToken.source();// 创建一个取消令牌资源
		config['cancelToken'] = source.token;// 从资源中获得取消令牌，并在请求的cancelToken配置项上配置取消令牌
		if (!requestInfoPool.putRequstInfo(config)) { //存在没有结束的相同请求
			source.cancel('重复请求 ' + config.url + ' 已被阻止。');//取消请求
			//console.error('阻止重复请求：', config);
			return config;
		}

		if (config.loading) { //如果设置显示loading

			loadingCount.count++;
			if (!sureLoading.loading) sureLoading.show();
		}

		return config;
	},
	function (error) {
		// 对请求错误做些什么
		message.error('请求失败！');
		return Promise.reject(error);
	}
);


instance.interceptors.response.use(function (response) {

	// 请求成功做点什么
	console.log("成功响应：", response.config.baseURL + response.config.url, response);
	//从请求信息池中清除已经结束的请求信息
	requestInfoPool.removeRequestInfo(response.config);

	if (response.config.loading) { //如果设置显示loading
		loadingCount.count--;
		// if ((loadingCount.count === 0 || loadingCount.count < 0) && hide) {
		// 	hide();
		// 	hide = null;
		// }

		if ((loadingCount.count === 0 || loadingCount.count < 0) && sureLoading.loading) sureLoading.close();
	}

	return response;

}, function (error) {

	console.error("token：", getToken());

	if (!error.config) {
		console.log("错误响应：", error, "config:", error.config, "response:", error.response, "request:", error.request);
	}

	if (error.config) {
		console.error("错误响应：", error.config.baseURL + error.config.url, error);
	}

	if (error.config) {
		//从请求信息池中清除已经结束的请求信息
		requestInfoPool.removeRequestInfo(error.config);

		if (error.config.loading) { //如果设置显示loading
			loadingCount.count--;
			// if ((loadingCount.count === 0 || loadingCount.count < 0) && hide) {
			// 	hide();
			// 	hide = null;
			// }

			if ((loadingCount.count === 0 || loadingCount.count < 0) && sureLoading.loading) sureLoading.close();
		}
	} else {
		//不作为
	}



	if (error.response) {
		// The request was made and the server responded with a status code
		// that falls out of the range of 2xx


		const data = error.response.data;


		if (data && (data.code === CODE_INVALID_TOKEN)) { //令牌失效

			console.error("-令牌失效-")
			if (getLocalToken()) {
				removeLocalToken();
				message.error('登录令牌失效！请重新登录。');
			}
			router.replace({
				name: LOGIN_ROUTE_NAME
			});




		} else if (data && (data.message || typeof data.code === 'number')) {
			message.error(getCodeMessage(data));

		} else if (error.response.status === undefined || error.response.status === null || error.response.status === 0) {
			message.error('服务不可用！');

		} else {
			message.error(getHttpMessage(error.response.status));
		}

	} else if (error.request) {
		// The request was made but no response was received
		// `error.request` is an instance of XMLHttpRequest in the browser and an instance of
		// http.ClientRequest in node.js
		message.error('服务无响应！');
		console.error(error.request);
	} else if (!axios.isCancel(error)) {//如果不是被取消的请求
		// Something happened in setting up the request that triggered an Error
		message.error(error.message);
		console.error('Error', error.message);
	}

	return Promise.reject(error);
});



const ajax = function (getAxiosPromise) {

	let promise = new Promise((resolve, reject) => {

		try {

			getAxiosPromise()
				.then(response => { //处理成功响应返回的数据


					//如果是下载文件
					if (response.data && response.config.method.toLowerCase() == 'get' && response.config.responseType === 'blob') {
						resolve(response.data);
						return;
					}

					const data = response.data || {};
					if (isSuccessful(data)) { //操作成功

						if (response.config.servMsg === true && data.message && data.message.trim()) { //如果设置显示服务端消息，并且服务端有消息，则显示
							if (response.config.servMsgSync) { //服务端消息是否同步显示
								message.success(data.message).then(() => {
									resolve(data);
								});
							} else {
								message.success(data.message);
								resolve(data);
							}

						} else {

							resolve(data);

						}

						return;
					}

					// 令牌失效,直接跳转至登录页
					if (data.code === CODE_INVALID_TOKEN) { //令牌失效
						console.error("-令牌失效-")
						if (getLocalToken()) {
							removeLocalToken();
							message.error('请重新登录！');
						}
						router.replace({
							name: LOGIN_ROUTE_NAME
						});
						reject(response);
						return;
					}

					//提示错误
					message.error(getCodeMessage(data)).then(() => {
						reject(response);
					});

				})
				.catch(err => { //处理错误响应

					if (axios.isCancel(err)) {
						console.error("请求取消：", err.message);
					} else {
						reject(err.response);
					}


				});

		} catch (error) { //发生异常

			console.log(error);

			message.error('错误:' + error.message);

			throw error;

		}

	});

	return promise;

};


const operate = function (getAxiosPromise, config) {

	return new Promise((resolve, reject) => {

		if (config && config.message && config.title) {

			const onOk = () => {

				ajax(getAxiosPromise, config)
					.then(data => {
						resolve(data);
					}).catch(err => {
						reject(err)
					})
			};

			message.confirm({
				title: config.title,
				content: config.message
			})
				.then(onOk)
				.catch(() => { });



		} else {

			ajax(getAxiosPromise, config)
				.then(data => {
					resolve(data);
				}).catch(err => {
					console.error("error:", err);
					reject(err);
				});

		}

	});

};

const $get = function (url, params, config) {

	if (params && typeof params === 'object') {
		config = config || {};
		config['params'] = params;
		config['params']['_t'] = new Date().getTime();
	} else {
		config = {
			params: {
				_t: new Date().getTime()
			}
		};
	}


	return ajax(() => instance.get(url, config))


};

const $getBlob = function (url, params, config) {


	if (params && typeof params === 'object') {
		config = config || {};
		config['params'] = params;
		config['params']['_t'] = new Date().getTime();
		config['responseType'] = 'blob';
	} else {
		config = {
			params: {
				_t: new Date().getTime()
			},
			responseType: 'blob'
		};
	}


	return ajax(() => instance.get(url, config))




};

const $post = function (url, data, config) {

	return operate(() => instance.post(url, data, config), config);

};

const $put = function (url, data, config) {

	return operate(() => instance.put(url, data, config), config);

};

const $delete = function (url, data, config) {

	if (data && typeof data === 'object') {
		config = config || {};
		config['data'] = data;
	}

	return operate(() => instance.delete(url, config), config);

};



/*
给Vue添加原型方法，以application/x-www-form-urlencoded编码格式，向服务器发出post请求，返回promise，
then方法的参数是一个函数，该函数的参数为服务器发送的未经包装响应数据
*/
const $postFormData = function (url, data, config) {
	if (!config) {
		config = {};
	}

	if (!config.headers) {
		config.headers = {
			"Content-Type": 'application/x-www-form-urlencoded',
			"Token": getToken()
		};
	} else {
		config.headers['Content-Type'] = 'application/x-www-form-urlencoded';
		config.headers['Token'] = getToken()
	}

	config.transformRequest = [function (data) {

		if (!data || typeof (data) === 'string') {
			return data;
		}

		if (!(typeof (data) === 'object')) {
			return data;
		}


		let params = [];
		for (let prop in data) {
			if (data[prop] instanceof Array) {
				let arr = data[prop];
				for (let i = 0; i < arr.length; i++) {
					params.push(prop + "=" + arr[i]);
				}
			} else {
				params.push(prop + "=" + data[prop]);
			}

		}
		return params.join("&");

	}];

	config.requestMethod = 'postFormData';
	config.initialData = { ...config.data };//记录原始请求数据

	return operate(() => instance.post(url, data, config), config);

};

export const get = $get;
export const post = $post;
export const put = $put;
export const del = $delete;
export const postFormData = $postFormData;
export const getBlob = $getBlob;


export default {
	install(app) {
		app.config.globalProperties.$axios = instance;
		app.config.globalProperties.$apiBaseUrl = API_BASE_URL;
		app.config.globalProperties.$httpGet = $get;
		app.config.globalProperties.$httpPost = $post;
		app.config.globalProperties.$httpPut = $put;
		app.config.globalProperties.$httpDelete = $delete;
		app.config.globalProperties.$httpPostFormData = $postFormData;
		app.config.globalProperties.$httpGetBlob = $getBlob;
	},
	axios: instance,
	baseUrl: API_BASE_URL,
	get: $get,
	post: $post,
	put: $put,
	delete: $delete,
	postFormData: $postFormData,
	getBlob: $getBlob
};
