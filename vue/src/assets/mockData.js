// 基于《东软体检项目》数据库设计的模拟数据。
// 后端目前仅实现了 /user/findall，其余接口用前端 mock 演示，接口层见 src/api/index.js。

export const hospitals = [
  {
    hpId: 1,
    name: '沈阳熙康云医院-和平院区',
    picture: '',
    telephone: '4006257568',
    address: '辽宁省沈阳市和平区三好街36号',
    businessHours: '周一至周五 7:30-15:30（周六截止12:00）',
    deadline: '采血截止时间 10:30',
    rule: '每日限约200人',
    state: 1,
  },
  {
    hpId: 2,
    name: '沈阳熙康云医院-浑南院区',
    picture: '',
    telephone: '4006257568',
    address: '创新路175号（新市府北文澜苑）',
    businessHours: '周一至周六 7:30-11:30',
    deadline: '采血截止时间 10:30',
    rule: '每日限约200人',
    state: 1,
  },
  {
    hpId: 3,
    name: '沈阳熙康云医院-大东院区',
    picture: '',
    telephone: '4006257568',
    address: '辽宁省沈阳市大东区小什字街1号',
    businessHours: '周一至周五 7:30-15:30',
    deadline: '采血截止时间 10:00',
    rule: '每日限约150人',
    state: 1,
  },
]

export const setmeals = [
  { smId: 1, name: '男士套餐-基础套餐', type: 1, price: 350, desc: '肝脏检查，健康基础', items: ['血常规', '尿常规', '肾功能', '心电图'] },
  { smId: 2, name: '男士套餐-脑血管系统', type: 1, price: 480, desc: '肝脏检查，心脑血管筛查', items: ['血常规', '血脂', '心电图', '颈动脉彩超'] },
  { smId: 3, name: '男士套餐-肝肾检查', type: 1, price: 399, desc: '肝脏检查，肝肾专项', items: ['血常规', '尿常规', '肝功能', '肾功能'] },
  { smId: 4, name: '男士套餐-肝病检查', type: 1, price: 420, desc: '肝脏检查，肝病专项', items: ['血常规', '肝功能', '乙肝五项'] },
  { smId: 5, name: '女士套餐-基础套餐', type: 0, price: 350, desc: '常规体检，健康基础', items: ['血常规', '尿常规', '肾功能', '心电图'] },
  { smId: 6, name: '女士套餐-肾病检查', type: 0, price: 450, desc: '肾脏专项检查', items: ['血常规', '尿常规', '肾功能', '泌尿系彩超'] },
  { smId: 7, name: '女士套餐-肝病检查', type: 0, price: 460, desc: '肝脏专项检查', items: ['血常规', '肝功能', '乙肝五项'] },
  { smId: 8, name: '女士套餐-妇科专项', type: 0, price: 520, desc: '妇科专项检查', items: ['血常规', '尿常规', '妇科检查', '乳腺检查'] },
]

export const users = [
  {
    userId: '15642388888',
    password: '123456',
    realName: '黄药师',
    sex: 1,
    identityCard: '210106103610241547',
    birthday: '1986-10-24',
    userType: 1,
  },
  {
    userId: '12345671111',
    password: '123456',
    realName: '叶文洁',
    sex: 0,
    identityCard: '210106198801011111',
    birthday: '1988-01-01',
    userType: 1,
  },
  {
    userId: '12345678222',
    password: '123456',
    realName: '东方延绪',
    sex: 0,
    identityCard: '210106198902022222',
    birthday: '1989-02-02',
    userType: 1,
  },
  {
    userId: '12345678111',
    password: '123456',
    realName: '托马斯·维德',
    sex: 1,
    identityCard: '210106197903033333',
    birthday: '1979-03-03',
    userType: 1,
  },
  {
    userId: '12345679999',
    password: '123456',
    realName: '杨冬',
    sex: 0,
    identityCard: '210106199004044444',
    birthday: '1990-04-04',
    userType: 1,
  },
  {
    userId: '12345678888',
    password: '123456',
    realName: '丁仪',
    sex: 1,
    identityCard: '210106198505055555',
    birthday: '1985-05-05',
    userType: 1,
  },
]

export const doctors = [
  { docId: 1, docCode: 'sun', realName: '孙思邈', password: '123456', sex: 1, deptno: 1 },
  { docId: 2, docCode: 'zhang', realName: '张仲景', password: '123456', sex: 1, deptno: 2 },
]

const userIds = users.map((u) => u.userId)

export const orders = [
  { orderId: 100569833, orderDate: '2022-01-19', userId: userIds[1], hpId: 1, smId: 8, state: 1 },
  { orderId: 100569832, orderDate: '2022-01-18', userId: userIds[2], hpId: 2, smId: 6, state: 1 },
  { orderId: 100569831, orderDate: '2022-01-18', userId: userIds[3], hpId: 2, smId: 4, state: 1 },
  { orderId: 100569830, orderDate: '2022-01-17', userId: userIds[4], hpId: 1, smId: 7, state: 1 },
  { orderId: 100569829, orderDate: '2022-01-17', userId: userIds[5], hpId: 2, smId: 4, state: 1 },
  { orderId: 100569828, orderDate: '2022-01-17', userId: userIds[1], hpId: 1, smId: 6, state: 1 },
  { orderId: 100569827, orderDate: '2022-01-17', userId: userIds[2], hpId: 2, smId: 6, state: 2 },
  { orderId: 100569826, orderDate: '2022-01-14', userId: userIds[3], hpId: 1, smId: 1, state: 2 },
  { orderId: 100569825, orderDate: '2022-01-13', userId: userIds[4], hpId: 2, smId: 4, state: 2 },
  { orderId: 100569824, orderDate: '2022-01-12', userId: userIds[5], hpId: 1, smId: 6, state: 2 },
  { orderId: 100569823, orderDate: '2026-11-20', userId: '15642388888', hpId: 1, smId: 1, state: 1 },
]

// 体检报告（cireport + cidetailedreport），按 orderId 组织
export const reports = [
  {
    cirId: 1,
    orderId: 100569832,
    ciName: '血常规',
    items: [
      { name: '白细胞计数', unit: '10^9/L', minrange: 3.5, maxrange: 9.5, value: '6.5', isError: 0, type: 1, normalValueString: '正常值范围:3.5-9.5' },
      { name: '红细胞计数', unit: '10^12/L', minrange: 3.5, maxrange: 5.5, value: '5.9', isError: 1, type: 1, normalValueString: '正常值范围:3.5-5.5' },
      { name: '血小板计数', unit: '10^9/L', minrange: 100, maxrange: 300, value: '200', isError: 0, type: 1, normalValueString: '正常值范围:100-300' },
      { name: '血红蛋白', unit: 'g/L', minrange: 110, maxrange: 150, value: '130', isError: 0, type: 1, normalValueString: '正常值范围:110-150' },
    ],
  },
  {
    cirId: 2,
    orderId: 100569832,
    ciName: '尿常规',
    items: [
      { name: '尿白细胞', unit: '/ul', minrange: null, maxrange: null, value: '+', isError: 1, type: 4, normalValueString: '正常值范围:-' },
      { name: '尿亚硝酸盐', unit: '', minrange: null, maxrange: null, value: '+', isError: 1, type: 4, normalValueString: '正常值范围:-（阴性）' },
      { name: '尿液酸碱度', unit: '', minrange: 5.5, maxrange: 6.5, value: '9', isError: 1, type: 1, normalValueString: '正常值范围:5.5-6.5' },
      { name: '尿蛋白定性', unit: 'g/L', minrange: null, maxrange: null, value: '-', isError: 0, type: 4, normalValueString: '正常值范围:-' },
      { name: '尿比重', unit: '', minrange: 1.015, maxrange: 1.025, value: '1.025', isError: 0, type: 1, normalValueString: '正常值范围:1.015-1.025' },
      { name: '尿维生素', unit: 'mmol/L', minrange: 0, maxrange: 0, value: '0', isError: 0, type: 1, normalValueString: '正常值范围:0' },
    ],
  },
  {
    cirId: 3,
    orderId: 100569832,
    ciName: '肾功能',
    items: [
      { name: '血清肌酐', unit: 'umol/L', minrange: 41, maxrange: 111, value: '111', isError: 0, type: 1, normalValueString: '正常值范围:41-111' },
      { name: '血尿素氮', unit: 'mmol/L', minrange: 2.85, maxrange: 7.14, value: '5', isError: 0, type: 1, normalValueString: '正常值范围:2.85-7.14' },
      { name: '血尿酸', unit: 'umol/L', minrange: 208, maxrange: 428, value: '200', isError: 1, type: 1, normalValueString: '正常值范围:208-428' },
    ],
  },
  {
    cirId: 4,
    orderId: 100569832,
    ciName: '妇科检查',
    items: [
      { name: '盆腔检查', unit: '', minrange: null, maxrange: null, value: '正常', isError: 0, type: 5, normalValueString: '' },
      { name: '乳腺检查', unit: '', minrange: null, maxrange: null, value: '正常', isError: 0, type: 5, normalValueString: '' },
      { name: '子宫检查', unit: '', minrange: null, maxrange: null, value: '正常', isError: 0, type: 5, normalValueString: '' },
    ],
  },
]

// 总检结论（overallresult）
export const overallResults = [
  { orId: 1, orderId: 100569832, title: '超重', content: '超重，建议控制饮食并加强运动。' },
  { orId: 2, orderId: 100569832, title: '血压高要进一步检查', content: '血压高要进一步检查，建议复查血压并咨询内科医生。' },
  {
    orId: 3,
    orderId: 100569824,
    title: '一般检查',
    content: '您的体重指数超重，体内脂肪蓄积过度，使体重超正常值，易引起高血压、糖尿病、冠心病及免疫功能降低等并发症，建议合理膳食，以低脂、低糖、低盐饮食，多做有氧运动。',
  },
]
