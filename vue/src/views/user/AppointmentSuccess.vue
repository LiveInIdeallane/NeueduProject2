<script setup>
import { useRouter } from 'vue-router'
import { resetAppointment } from '@/assets/appointment'

const router = useRouter()

function again() {
  resetAppointment()
  router.push('/appointment/type')
}
</script>

<template>
  <div class="success">
    <div class="top">
      <div class="check"><el-icon><Select /></el-icon></div>
      <h2>恭喜您预约成功！</h2>
      <p>请体检用户携带本人身份证到院体检</p>
    </div>

    <div class="body">
      <el-button type="primary" plain round @click="router.push('/orders')">查看订单</el-button>
      <button class="btn-primary again" @click="again">继续为家人预约</button>
      <div class="notice">
        <p>您的信息已经发送至体检机构</p>
        <p>如需修改请提前一天联系客服</p>
        <p>客服电话 4008-XXX-XXX</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.success {
  min-height: calc(100vh - 60px);
  display: flex;
  flex-direction: column;
}
.top {
  background: linear-gradient(120deg, #6f8f4e, #8fae6a);
  color: #fff;
  padding: 40px 20px 46px;
  text-align: center;
  border-radius: 0 0 30px 30px;
}
.check {
  width: 62px;
  height: 62px;
  border-radius: 50%;
  border: 3px solid rgba(255, 255, 255, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  font-size: 30px;
}
.top h2 {
  margin: 0 0 8px;
  letter-spacing: 2px;
}
.top p {
  margin: 0;
  font-size: 13px;
  opacity: 0.85;
}
.body {
  padding: 30px 24px;
  text-align: center;
}
.body .el-button {
  min-width: 180px;
}
.again {
  margin-top: 14px;
  width: 220px;
}
.notice {
  margin-top: 34px;
  font-size: 12px;
  color: #a3aa97;
  line-height: 1.9;
}
.notice p {
  margin: 0;
}
</style>
