//axios统一封装
import axios from 'axios'

// 真实后端地址（Tomcat 部署的 maven war，context-path 为 /maven_war_exploded）
// Docker 中由 Nginx 反向代理到 backend:8080，所以使用相对路径
export const BASE_URL =
  import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/maven_war_exploded'

//创建axios实例
//为什么用axios.create而不直接用axios?
//因为axios是全局单例，改变其defaults会污染全局
// create返回一个独立实例（有自己的defaults,interceptors，底层还是走Axios.prototype.request,行为完全一样）
//baseURL所有请求的相对路径前自动拼接
//timeout超过10秒自动中断并reject
const request = axios.create({
  baseURL: BASE_URL,
  timeout: 10000,
})
//所以request.get('/user/list')实际请求的是：http://localhost:8080/maven_war_exploded/user/list

//响应拦截器
//把后端的{code,message,data}拆包，让业务代码直接拿data
//reponse是axios包装的响应对象(从服务器端发给前端的数据)
request.interceptors.response.use(
  (response) => {
    const body = response.data
    if (body && typeof body === 'object' && 'code' in body) {
      if (body.code === 200) return body
      //const res = await request.get('/user/1')
      //=> res = {code:200,message:'ok',data:{id:1,name:'张三'}}

      return Promise.reject(new Error(body.message || '请求失败'))
    }
    return body
  }, //成功回调：HTTP 2xx
  (error) => Promise.reject(error), //失败回调：HTTP 4xx/5xx、网络错误、超时
)

//导出这个实例
export default request
