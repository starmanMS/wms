<template>
  <div class="report-charts-title" >国际云仓储数据中心</div>
  <div class="report-charts">
    <div class="charts" ref="chart1" ></div>
    <div class="charts" ref="chart2" ></div>
    <div class="charts" ref="chart3" ></div>
    <div class="charts" ref="chart4" style="margin-top: 20px;"></div>
    <div class="charts" ref="chart5" style="margin-top: 20px;"></div>
    <div class="charts" style="margin-top: 20px;">
      <h3>今日实时数据监测：</h3>
      <div class="container">
        <div>
          <label>采购量：</label>
          <span>68件</span>
        </div>
        <div>
          <label>入库量：</label>
          <span>264件</span>
        </div>
        <div>
          <label>出库量：</label>
          <span>136件</span>
        </div>
        <div>
          <label>调货量：</label>
          <span>37件</span>
        </div>
      </div>
    </div>
  </div>
  
</template>

<script setup >
import { nextTick, onMounted, reactive, ref, watch } from "vue";
import { tip, get, post, del, removeLocalToken, ddo } from "@/common";
import * as echarts from 'echarts';

const chart1 = ref();
const chart2 = ref();
const chart3 = ref();
const chart4 = ref();
const chart5 = ref();

let chartObj1;
let chartObj2;
let chartObj3;
let chartObj4;
let chartObj5;

const makeChart = (chartRef, option) => {
  const chartObj = echarts.init(chartRef.value);
  chartObj.setOption(option);
  return chartObj;
};

onMounted(() => {
  nextTick(() => {
    chartObj1 = makeChart(chart1, option1);
    chartObj1.resize({ height: 280 });
    chartObj2 = makeChart(chart2, option2);
    chartObj2.resize({ height: 260 });
    chartObj3 = makeChart(chart3, option3);
    chartObj4 = makeChart(chart4, option4);
    chartObj4.resize({ height: 280 });
    chartObj5 = makeChart(chart5, option5);
  });
});

// 刷新chart视图
const refreshChart = (chartObj, option) => {
  if (!chartObj) {
    nextTick(() => {
      refreshChart(chartObj, option);
    });
  } else {
    chartObj.setOption(option);
  }
};

// 1. 各仓库的库存情况
const option1 = reactive({
  title: {
    text: '在库库存信息'
  },
  legend: {
    orient: "horizontal",
    /* orient: 'vertical', */
    right: 5,
    /* top: 'center' */
  },
  tooltip: {
    
  },
  dataset: {
    dimensions: ['product', '西安仓库', '北京仓库', '上海仓库'],
    source: [
      { product: '', '西安仓库': 0, '北京仓库': 0, '上海仓库': 0 },
      /* { product: 'Milk Tea', 2015: 83.1, 2016: 73.4, 2017: 55.1 },
      { product: 'Cheese Cocoa', 2015: 86.4, 2016: 65.2, 2017: 82.5 },
      { product: 'Walnut Brownie', 2015: 72.4, 2016: 53.9, 2017: 39.1 } */
    ]
  },
  xAxis: {  type: 'category' },
  yAxis: {name: '单位：件/箱'},
  series: [{ type: 'bar' }, { type: 'bar' }, { type: 'bar' }]
});

// 监视器
watch(option1, (newOption, oldOption) => refreshChart(chartObj1, newOption));
// 获取仓库的商品库存
const getStoreInvent = () => {
  get('/statistics/store-invent').then(res => {
    const source = [{product: ''}];
    res.data.forEach(e => {
      source[0][e.storeName] = e.totalInvent;
    });
    option1.dataset.source = source;
  });
}
getStoreInvent();


// 2. 占用比
const option2 = reactive({
  series: [
    {
      type: 'gauge',
      progress: {
        show: true,
        width: 8
      },
      axisLine: {
        lineStyle: {
          width: 8
        }
      },
      axisTick: {
        show: false
      },
      splitLine: {
        length: 5,
        lineStyle: {
          width: 2,
          color: '#999'
        }
      },
      axisLabel: {
        distance: 12,
        color: '#999',
        fontSize: 13
      },
      anchor: {
        show: true,
        showAbove: true,
        size: 20,
        itemStyle: {
          borderWidth: 10
        }
      },
      title: {
        show: true
      },
      detail: {
        valueAnimation: true,
        fontSize: 14,
        offsetCenter: [0, '60%'],
        formatter: '占用比\n{value}%'
      },
      data: [
        {
          value: 56.43,
        }
      ]
    }
  ]
});

// 3. 各仓库存储走势
const option3 = reactive({
  title: {
    text: new Date().getFullYear() + '仓库存储走势'
  },
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    orient: "vertical",
    right: 5,
    top: -5,
    data: ['西安仓库', '北京仓库', '上海仓库']
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  toolbox: {
    
  },
  xAxis: {
    type: 'category',
    boundaryGap: false,
    data: ['1月', '2月', '3月', '4月', '5月', '6月']
  },
  yAxis: {
    name: '单位：件/箱',
    type: 'value'
  },
  series: [
    {
      name: '西安仓库',
      type: 'line',
      stack: 'Total',
      data: [120, 132, 101, 134, 90, 230]
    },
    {
      name: '北京仓库',
      type: 'line',
      stack: 'Total',
      data: [220, 182, 191, 234, 290, 330]
    },
    {
      name: '上海仓库',
      type: 'line',
      stack: 'Total',
      data: [150, 232, 201, 154, 190, 330]
    }
  ]
});

// 4. 各仓库出库入库情况
const option4 = reactive({
  title: {
    text: new Date().getFullYear() + '年出入库信息'
  },
  legend: {
    orient: "horizontal",
    right: 10
  },
  tooltip: {
    
  },
  dataset: {
    dimensions: ['product', '入库', '出库'],
    source: [
      { product: '1月', '入库': 2045, '出库': 1153 },
      { product: '2月', '入库': 1842, '出库': 1541 },
      { product: '3月', '入库': 2684, '出库': 2315 },
      { product: '4月', '入库': 2478, '出库': 1936 },
    ]
  },
  xAxis: {  type: 'category' },
  yAxis: {name: '单位：件/箱'},
  series: [{ type: 'bar' }, { type: 'bar' }]
});


// 5. 仓库采购量
const option5 = reactive({
  title: {
    text: '采购量占比',
    subtext: '',
    left: 'center'
  },
  tooltip: {
    trigger: 'item'
  },
  legend: {
    orient: 'vertical',
    left: 'left'
  },
  series: [
    {
      name: 'Access From',
      type: 'pie',
      radius: '65%',
      data: [
        { value: 548, name: '洗衣机' },
        { value: 735, name: '电视机' },
        { value: 580, name: '空调' },
        { value: 1580, name: '风扇' },
        { value: 880, name: '蔬菜' },
        { value: 1980, name: '水果' },
      ],
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      }
    }
  ]
});

// 6. 
const option6 = reactive({
  
});




</script>

<style scoped>
.report-charts-title{
  text-align: center;
  font-size: 30px;
  font-weight: bold;
  padding-bottom: 6px;
  letter-spacing: 8px;
  color:#100C2A;
}
.report-charts {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.report-charts .charts {
  width: 32%;
  height: 240px;
  flex: atuo;
  box-sizing: border-box;
}
.container{
  font-size: 17px;
  font-family: 黑体;

  display: flex;
  flex-direction: column;
}
.container>div{
  margin-top: 10px;
}
</style>