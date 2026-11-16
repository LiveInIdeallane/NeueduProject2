// import { doctors, hospitals, orders, overallResults, reports, setmeals, users } from './mockData'

//从mock换成axios请求
import request from './request'

// // 模拟网络延迟
// const wait = (data, ms = 260) => new Promise((resolve) => setTimeout(() => resolve(data), ms))
// const clone = (v) => JSON.parse(JSON.stringify(v))

// let orderSeq = 100569900
// let resultSeq = 100

/* ---------------- 用户 ---------------- */

//登录
// export async function login(userId, password) {
//   const user = users.find((u) => u.userId === userId && u.password === password)
//   if (!user) throw new Error('手机号码或密码错误')
//   return wait(clone(user))
// }

export async function login(userId, password) {
  const response = await request.post('/user/login', { userId, password })
  return response.data //获取到后端返回的用户数据
}

//注册
// export async function register(payload) {
//   if (users.some((u) => u.userId === payload.userId)) {
//     throw new Error('该手机号码已注册')
//   }
//   const user = { ...payload, userType: payload.userType ?? 1 }
//   users.push(user)
//   return wait(clone(user))
// }

export async function register(payload) {
  const response = await request.post('/user/register', payload)
  return response.data //获取到后端返回的用户数据
}

/* ---------------- 医院 / 套餐 ---------------- */

//获取医院列表
// export async function getHospitals() {
//   return wait(clone(hospitals.filter((h) => h.state === 1)))
// }

export async function getHospitals() {
  const response = await request.get('/hospital/findall')
  return response.data //获取到后端返回的医院列表数据
}

//获取医院详情
// export async function getHospital(hpId) {
//   return wait(clone(hospitals.find((h) => h.hpId === Number(hpId))))
// }

export async function getHospital(hpId) {
  const response = await request.get(`/hospital/findone/${hpId}`)
  return response.data //获取到后端返回的医院详情数据
}

//获取套餐列表
// export async function getSetmeals(type) {
//   const list = type === undefined ? setmeals : setmeals.filter((s) => s.type === Number(type))
//   return wait(clone(list))
// }

export async function getSetmeals(type) {
  const response = await request.get('/setmeal/findall', { params: { type } })
  return response.data //获取到后端返回的套餐列表数据
}

//获取套餐详情
// export async function getSetmeal(smId) {
//   return wait(clone(setmeals.find((s) => s.smId === Number(smId))))
// }

export async function getSetmeal(smId) {
  const response = await request.get(`/setmeal/findone/${smId}`)
  return response.data //获取到后端返回的套餐详情数据
}

/* ---------------- 订单 ---------------- */

// function joinOrder(order) {
//   const user = users.find((u) => u.userId === order.userId) || {}
//   const hospital = hospitals.find((h) => h.hpId === order.hpId) || {}
//   const setmeal = setmeals.find((s) => s.smId === order.smId) || {}
//   return {
//     ...order,
//     realName: user.realName,
//     sex: user.sex,
//     identityCard: user.identityCard,
//     birthday: user.birthday,
//     hospitalName: hospital.name,
//     hospital,
//     setmealName: setmeal.name,
//     price: setmeal.price,
//     type: setmeal.type,
//   }
// }

//创建订单
// export async function createOrder(payload) {
//   const order = {
//     orderId: ++orderSeq,
//     orderDate: payload.orderDate,
//     userId: payload.userId,
//     hpId: Number(payload.hpId),
//     smId: Number(payload.smId),
//     state: 1,
//   }
//   orders.unshift(order)
//   return wait(joinOrder(order))
// }

export async function createOrder(payload) {
  const response = await request.post('/order/create', payload)
  return response.data //获取到后端返回的订单数据
}

//获取用户订单列表
// export async function getOrdersByUser(userId) {
//   const list = orders.filter((o) => o.userId === userId).map(joinOrder)
//   return wait(clone(list))
// }

export async function getOrdersByUser(userId) {
  const response = await request.get('/order/findbyuser', { params: { userId } })
  return response.data //获取到后端返回的订单列表数据
}

//获取订单详情
// export async function getOrder(orderId) {
//   const order = orders.find((o) => o.orderId === Number(orderId))
//   return wait(order ? clone(joinOrder(order)) : null)
// }

export async function getOrder(orderId) {
  const response = await request.get(`/order/findone/${orderId}`)
  return response.data //获取到后端返回的订单详情数据
}

//取消订单
// export async function cancelOrder(orderId) {
//   const index = orders.findIndex((o) => o.orderId === Number(orderId))
//   if (index > -1) orders.splice(index, 1)
//   return wait(true)
// }

export async function cancelOrder(orderId) {
  const response = await request.post(`/order/cancel/${orderId}`)
  return response.data //获取到后端返回的取消订单结果
}

/* ---------------- 体检报告 ---------------- */

//获取用户体检报告列表
// export async function getReportsByUser(userId) {
//   const orderIds = orders.filter((o) => o.userId === userId).map((o) => o.orderId)
//   const list = orderIds
//     .map((id) => {
//       const order = orders.find((o) => o.orderId === id)
//       return order ? joinOrder(order) : null
//     })
//     .filter(Boolean)
//   return wait(clone(list))
// }

export async function getReportsByUser(userId) {
  const reponse = await request.get(`/report/list/${userId}`)
  return reponse.data
}

//获取某个订单的详细报告
// export async function getReportByOrder(orderId) {
//   const id = Number(orderId)
//   const groups = reports.filter((r) => r.orderId === id)
//   const conclusions = overallResults.filter((o) => o.orderId === id)
//   const order = orders.find((o) => o.orderId === id)
//   return wait(
//     clone({
//       order: order ? joinOrder(order) : null,
//       groups,
//       conclusions,
//     }),
//   )
// }

export async function getReportByOrder(orderId) {
  const reponse = await request.get(`/report/detail/${orderId}`)
  return reponse.data
}

//保存报告分组内容
// export async function saveReportGroup(orderId, cirId, items) {
//   const group = reports.find((r) => r.cirId === Number(cirId) && r.orderId === Number(orderId))
//   if (group) group.items = items
//   return wait(true)
// }

export async function saveReportGroup(orderId, cirId, items) {
  const reponse = await request.post('/report/saveGroup', { orderId, cirId, items })
  return reponse.data
}

//添加总检结论
// export async function addOverallResult(orderId, title, content) {
//   const item = { orId: ++resultSeq, orderId: Number(orderId), title, content }
//   overallResults.push(item)
//   return wait(clone(item))
// }

export async function addOverallResult(orderId, title, content) {
  const reponse = await request.post('/report/addResult', { orderId, title, content })
  return reponse.data
}

//更新总检结论
// export async function updateOverallResult(orId, title, content) {
//   const item = overallResults.find((o) => o.orId === Number(orId))
//   if (item) {
//     item.title = title
//     item.content = content
//   }
//   return wait(true)
// }

export async function updateOverallResult(orId, title, content) {
  const reponse = await request.post('/report/updateResult', { orId, title, content })
  return reponse.data
}

//删除总检结论
// export async function deleteOverallResult(orId) {
//   const index = overallResults.findIndex((o) => o.orId === Number(orId))
//   if (index > -1) overallResults.splice(index, 1)
//   return wait(true)
// }

export async function deleteOverallResult(orId) {
  const reponse = await request.post(`/report/deleteResult/${orId}`)
  return reponse.data
}

//归档订单（修改状态）
// export async function archiveOrder(orderId) {
//   const order = orders.find((o) => o.orderId === Number(orderId))
//   if (order) order.state = 2
//   return wait(true)
// }

export async function archiveOrder(orderId) {
  const reponse = await request.post(`/order/archive/${orderId}`)
  return reponse.data
}

/* ---------------- 医生端 ---------------- */

//医生登录
// export async function doctorLogin(docCode, password) {
//   const code = String(docCode ?? '')
//     .trim()
//     .toLowerCase()
//   const pwd = String(password ?? '').trim()
//   const doctor = doctors.find((d) => d.docCode.toLowerCase() === code && d.password === pwd)
//   if (!doctor) throw new Error('医生工号或密码错误')
//   return wait(clone(doctor))
// }

export async function doctorLogin(docCode, password) {
  const reponse = await request.post('/doctor/login', { docCode, password })
  return reponse.data
}

//医生端查询客户
// export async function queryCustomers(filters = {}) {
//   let list = orders.map(joinOrder)
//   if (filters.userId) list = list.filter((o) => o.userId.includes(filters.userId))
//   if (filters.realName) list = list.filter((o) => (o.realName || '').includes(filters.realName))
//   if (filters.sex !== '' && filters.sex !== undefined && filters.sex !== null) {
//     list = list.filter((o) => o.sex === Number(filters.sex))
//   }
//   if (filters.type !== '' && filters.type !== undefined && filters.type !== null) {
//     list = list.filter((o) => o.type === Number(filters.type))
//   }
//   if (filters.orderDate) list = list.filter((o) => o.orderDate === filters.orderDate)
//   if (filters.state !== '' && filters.state !== undefined && filters.state !== null) {
//     list = list.filter((o) => o.state === Number(filters.state))
//   }
//   return wait(clone(list))
// }

export async function queryCustomers(filters = {}) {
  const reponse = await request.get('/doctor/queryCustomers', { params: filters })
  return reponse.data
}

//前端语法（axios与ES6模块化）
//1.post请求（提交数据，如登录，注册，创建订单）数据存放在body请求体中，后端servlet用req.getReader()来读取这个JSON字符串
//2.get请求（获取数据，如查列表，查详情）数据被axios自动拼接到URL的末尾，后端servlet用req.getParameter("type")就能拿到
//3.反引号`与模版字符串（路径传参）,后端使用路径截取或@PathVariable获取

//后端语法（servlet接收数据）

//1.接收get请求的patams参数。/hospital/list?state=1&page=2

//doGet(HttpServletRequest req, HttpServletResponse resp)
//String stateStr = req.getParameter("state");
//String pageStr = req.getParameter("page");
//Integer state = Integer.paseInt(stateStr)；

//2.接收post请求的JSONBody。前端发/user/login，body里是{"userId":"admin","password":"124"}
//doPost(HttpServletRequest req, HttpServletResponse resp)
//设置编码req.setCharacterEncoding("UTF-8");
//直接让Jackson从请求的输入流中读取并转换ObjectMapper mapper = new ObjectMapper();
//将请求体直接映射为一个Map对象Map<String,String> data = mapper.readValue(req.getInputStream(),Map.class);
//取值String userId = data.get("userId");String password = data.get("password");

//3.接收路径参数。/order/detail/100
//String uri = req.getRequestURI();
//String orderIdStr = uri.substring(uri.lastIndexOf("/")+1);
//int orderId = Integer.paseInt(orderIdStr);
