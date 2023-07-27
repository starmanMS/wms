import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'

const path = require('path');

export default ({ command, mode }) => {

  const env = loadEnv(mode, process.cwd()); // 获取（在.env文件中配置的）环境变量，

  return defineConfig({

    plugins: [vue()],

    base: env.VITE_BASE_URL, // 项目的基础路径由环境变量VITE_BASE_URL指定

    resolve: {
      // 使用"@"表示项目的src目录
      alias: { 
        '@': path.resolve(__dirname, './src'),
        /* 'excel': path.resolve(__dirname, '@/common/excel') */
      }
    },

    // vite 开发服务器配置
    server: {
      host: 'localhost', // 主机名
      port: 3000, // 端口
      open: true, // 启动项目时是自动打开浏览器
      strictPort: false, // 如果port指定端口被占用，是否仍然使用此端口（而不自动使用其它可用端口）
      https: false,// 是否使用https访问
      //服务端代理设置
      proxy: {
        //如果访问地址以"/api"开头,则自动代理到变量VITE_WAREHOUSE_CONTEXT_PATH所表示的
		//服务端地址http://localhost:9999/warehouse
        '/api': {
          target: env.VITE_WAREHOUSE_CONTEXT_PATH,
          changeOrigin: true,
          rewrite: path => path.replace(/^\/api/, '')
        }
      }
    },

    build: {
      outDir: env.VITE_OUTPUT_DIR // 项目打包输出目录由环境变量VITE_BASE_URL指定
    }
  })

}


