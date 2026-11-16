import { createRouter, createWebHistory } from 'vue-router'
import { getDoctor, getUser } from '@/assets/auth'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL), //决定浏览器地址栏的URL的显示方式
  routes: [
    { path: '/', redirect: '/login' }, //redirect重定向，访问/时跳转到/login
    { path: '/login', name: 'login', component: () => import('@/views/Login.vue') },
    { path: '/register', name: 'register', component: () => import('@/views/Register.vue') },
    {
      path: '/',
      component: () => import('@/components/UserLayout.vue'),
      meta: { area: 'user' }, //meta是路由元信息，存储自定义数据，路由本身不用他，但守卫函数可以读他来做判断
      children: [
        //子路由的path不以/开头，访问路径是父路由的path+子路由的path

        //home路由是用户区的默认路由，访问/时重定向到/home没有标记needLogin，用户区的其他路由都标记了needLogin，守卫函数会检查登录状态
        { path: 'home', name: 'home', component: () => import('@/views/user/Home.vue') },

        {
          path: 'appointment/type',
          name: 'appointment-type',
          component: () => import('@/views/user/AppointmentType.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'appointment/hospital',
          name: 'appointment-hospital',
          component: () => import('@/views/user/HospitalSelect.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'appointment/setmeal',
          name: 'appointment-setmeal',
          component: () => import('@/views/user/SetmealSelect.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'appointment/date',
          name: 'appointment-date',
          component: () => import('@/views/user/DateSelect.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'appointment/confirm',
          name: 'appointment-confirm',
          component: () => import('@/views/user/OrderConfirm.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'appointment/success',
          name: 'appointment-success',
          component: () => import('@/views/user/AppointmentSuccess.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'orders',
          name: 'orders',
          component: () => import('@/views/user/Orders.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'profile',
          name: 'profile',
          component: () => import('@/views/user/Profile.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'reports',
          name: 'reports',
          component: () => import('@/views/user/ReportList.vue'),
          meta: { needLogin: true },
        },
        {
          path: 'reports/:orderId', //这是动态参数，访问/report/123时，orderId的值就是123，可以使用useRoute()获取
          name: 'report-detail',
          component: () => import('@/views/user/ReportDetail.vue'),
          meta: { needLogin: true },
        },
      ],
    },
    { path: '/admin/login', redirect: { path: '/login', query: { role: 'doctor' } } },
    {
      path: '/admin',
      component: () => import('@/components/AdminLayout.vue'),
      meta: { area: 'admin', needDoctor: true },
      children: [
        { path: '', redirect: '/admin/customers' }, //路由/admin重定向到/admin/customers
        {
          path: 'customers',
          name: 'admin-customers',
          component: () => import('@/views/admin/CustomerList.vue'),
        },
        {
          path: 'report/:orderId',
          name: 'admin-report',
          component: () => import('@/views/admin/ReportEdit.vue'),
        },
      ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/home' }, //通配符路由，匹配所有未定义的路由，重定向到/home
  ],
})

//路由守卫，beforeEach在每次路由跳转前执行，to是目标路由，from是当前路由
//beforeEach的返回值决定去留
router.beforeEach((to) => {
  const user = getUser() //读取当前用户状态
  const doctor = getDoctor() //读取当前医生状态

  //to.matched和.some
  //to.matched(这次跳转匹配到的所有路由记录数组)
  //.some(record=>条件)(数组里任意一个满足条件就返回true)
  //为什么要用matched.some而不直接看to.meta?(因为meta.area定义在父路由上,子路由自己的meta没有area,matched包含父路由)
  const inUserArea = to.matched.some((record) => record.meta.area === 'user')
  const inAdminArea = to.matched.some((record) => record.meta.area === 'admin')

  //第一段：医生误入用户区。解释：如果要去用户区，且当前是医生登录，则把医生赶回后台
  if (inUserArea && doctor && !user) {
    return { name: 'admin-customers' }
  }

  //第二段：后台区域检查
  if (inAdminArea) {
    //1.普通用户误入后台。解释：如果普通用户要进后台，且当前是普通用户登录，则把用户赶回去
    if (user && !doctor) {
      return { name: 'home' }
    }
    //2.没登录误入后台。解释：如果不是医生登录的要进后台，则退回登录界面，redirect参数是登录后要跳转的目标路由
    // to.fullPath(完整路径)，登录后可以用router.push(to.query.redirect)跳回去
    if (!doctor) {
      return { name: 'login', query: { role: 'doctor', redirect: to.fullPath } }
    }
  }

  //第三段：登录检查。解释：如果目标路由需要登录，但当前没有登录，则退回登录界面，redirect参数是登录后要跳转的目标路由
  if (to.meta.needLogin && !user) {
    return { name: 'login', query: { redirect: to.fullPath } }
  }

  //所有检查通过，允许跳转
  return true
})

export default router
