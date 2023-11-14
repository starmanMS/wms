/**
 * 数据字典
 * 作者：王坤 2022-03
 */


import { reactive } from 'vue'

const ddo = {

	refresh: true, // 是否刷新

  currPath: [], // 当前页面路径

	text(mark, code) {
		const option = this[mark].find(item => item.value === code);
		return option ? option.label : '';
	},

	// 数据状态
	dataStatus:[
		{code:'00', label:'未确定'},
		{code:'22', label:'已确定'},
		{code:'55', label:'已启用'},
		{code:'77', label:'已禁用'},
		{code:'99', label:'逻辑删除'}	
	],

	// 性别
	sex: [{
		value: 1,
		label: '男'
	}, {
		value: 2,
		label: '女'
	}],

	// 学生类型
	studentType: [{
		value: 1,
		label: "专科在读"
	}, {
		value: 2,
		label: "本科在读"
	}, {
		value: 3,
		label: "硕士在读"
	}, {
		value: 4,
		label: "博士在读"
	}, {
		value: 5,
		label: '博士后在读'
	}],

	// 爱好
	hobby: [
		{ value: 1, label: '篮球' },
		{ value: 2, label: '小说' },
		{ value: 3, label: '游泳' },
		{ value: 4, label: '小提琴' },
		{ value: 5, label: '画画' },
		{ value: 6, label: '旅游' }
	],

	getHobbyString(hobbyCodeString, delimiter) {
		if (hobbyCodeString && (hobbyCodeString instanceof String || typeof hobbyCodeString === 'string')) {
			const arr = hobbyCodeString.split(delimiter || ',');
			return this.hobby.filter(item => arr.some(code => Number(code) == item.value)).map(item => item.label).join(delimiter || ',');
		}
		return '';
	},
	
	getTitleString(codeString, delimiter) {
		if (codeString && (codeString instanceof String || typeof codeString === 'string')) {
			const arr = codeString.split(delimiter || ',');
			return this.title.filter(item => arr.some(code => Number(code) == item.value)).map(item => item.label).join(delimiter || ',');
		}
		return '';
	},

	edu: [
		{ value: 1, label: '高中/中专' },
		{ value: 2, label: '专科' },
		{ value: 3, label: '本科' },
		{ value: 4, label: '硕士' },
		{ value: 5, label: '博士' }
	],

	// 初始化字典数据，forced表示是否强制从服务器获取最新数据
	init(forced) {

		if (this.refresh || forced) {

			// 在这里可以加入初始化逻辑

			this.refresh = false;
		}

	}

};

ddo.init();

export default reactive(ddo);
