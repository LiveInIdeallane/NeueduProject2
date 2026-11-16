//标准的前端本地持久化工具类
//核心作用：利用浏览器的localStorage（本地存储）,让用户的登录状态在刷新页面或关闭浏览器重新打开后依然保留

//localStorage是以键值对的形式存数据的
const USER_KEY = 'tj_user'
const DOCTOR_KEY = 'tj_doctor'

//核心读取函数
function read(key) {
  try {
    //localStorage.getItem(key)：去浏览器里找对应键名的数据
    return JSON.parse(localStorage.getItem(key) || 'null')
  } catch {
    return null
  }
}

//用户登录状态管理（导出给业务用的api）

//在Vue组件的任何地方调用，就能立刻拿到当前登录用户的信息
export const getUser = () => read(USER_KEY)
//登录成功后，调用此方法，会将后端返回的用户对象用JSON.stringify转成字符串,存进浏览器
export const setUser = (user) => localStorage.setItem(USER_KEY, JSON.stringify(user))
//用户点击“退出登录”时调用，直接把这条数据从浏览器中抹除
export const clearUser = () => localStorage.removeItem(USER_KEY)

//医生登录状态管理
export const getDoctor = () => read(DOCTOR_KEY)
export const setDoctor = (doctor) => localStorage.setItem(DOCTOR_KEY, JSON.stringify(doctor))
export const clearDoctor = () => localStorage.removeItem(DOCTOR_KEY)
