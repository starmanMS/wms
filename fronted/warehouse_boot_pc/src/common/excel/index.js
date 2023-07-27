/**
 * 封装请求组件
 * 作者：王坤 2022-03
 */
import { export_json_to_excel } from './Export2Excel'

const $export2excel = function(columns, list, fileName){
  let tHeader = []
  let filterVal = []
  columns.forEach(item =>{
      tHeader.push(item.title)
      filterVal.push(item.key)
  })
  const data = list.map(v => filterVal.map(j => v[j]))
  export_json_to_excel(tHeader, data, fileName);
}
 
export const export2excel = $export2excel;
 
export default {
   install(app) {
     app.config.globalProperties.$export = $export2excel;
   },
   export2excel: $export2excel
 };