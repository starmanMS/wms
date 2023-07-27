/**
 * 防抖和节流
 * 作者：王坤 2022-03
 */

//防抖
export const debounce = () => {
	let timer = null;
	return (func, delay = 300) => {
		if (timer) clearTimeout(timer);
		timer = setTimeout(func, delay);
	};
};

export const debounceInstance1 = debounce();
export const debounceInstance2 = debounce();
export const debounceInstance3 = debounce();


export const throttle = () => {
	let prev = new Date().getTime();
	return (func, delay = 300) => {
		const now = new Date().getTime();
		if (now - prev > delay) {
			func();
		}
		prev = now;
	};
};

//节流
export const throttleInstance1 = throttle();
export const throttleInstance2 = throttle();
export const throttleInstance3 = throttle();



export default {
	install(app) {
		app.config.globalProperties.$debounce = debounce;
		app.config.globalProperties.$debounceInstance1 = debounceInstance1;
		app.config.globalProperties.$debounceInstance2 = debounceInstance2;
		app.config.globalProperties.$debounceInstance3 = debounceInstance3;

		app.config.globalProperties.$throttle = throttle;
		app.config.globalProperties.$throttleInstance1 = throttleInstance1;
		app.config.globalProperties.$throttleInstance2 = throttleInstance2;
		app.config.globalProperties.$throttleInstance3 = throttleInstance3;
	}
};



