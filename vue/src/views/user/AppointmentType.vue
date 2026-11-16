<script setup>
import { useRouter } from 'vue-router'
import NavBar from '@/components/NavBar.vue'
import Aurora from '@/components/Aurora.vue'
import { appointment, saveAppointment } from '@/assets/appointment'

const router = useRouter()
const auroraStops = ['#3f4f31', '#9dbd7a', '#3f4f31']

function choose(type) {
  appointment.type = type
  appointment.hpId = null
  appointment.smId = null
  appointment.orderDate = ''
  saveAppointment()
  router.push('/appointment/hospital')
}
</script>

<template>
  <div>
    <NavBar title="用户体检预约" />
    <div class="hero">
      <Aurora class="hero-aurora" :color-stops="auroraStops" :amplitude="1.15" :blend="0.7" :speed="0.55" />
      <div class="hero-overlay"></div>
      <div class="hero-mask">
        <h2>唯有爱<br />不能等待</h2>
        <p>关爱家人，从一次健康体检开始</p>
      </div>
    </div>

    <div class="section narrow">
      <div class="types">
        <div class="type-card self" @click="choose(1)">
          <el-icon><User /></el-icon>
          <h3>本人预约</h3>
          <p>为自己选择体检机构与套餐</p>
        </div>
        <div class="type-card family" @click="choose(2)">
          <el-icon><UserFilled /></el-icon>
          <h3>家属预约</h3>
          <p>为家人预约健康体检</p>
        </div>
      </div>

      <div class="tips card">
        <div class="section-title"><span>预约流程</span></div>
        <ol>
          <li>选择体检类型</li>
          <li>选择体检机构</li>
          <li>选择体检套餐</li>
          <li>选择体检日期并确认订单</li>
        </ol>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hero {
  height: 250px;
  background: #3a4830;
  position: relative;
  margin: 0;
  overflow: hidden;
}
.hero-aurora {
  position: absolute;
  inset: 0;
  z-index: 0;
}
.hero-overlay {
  position: absolute;
  inset: 0;
  z-index: 1;
  background: linear-gradient(100deg, rgba(45, 55, 38, 0.62), rgba(45, 55, 38, 0.06));
}
.hero-mask {
  position: relative;
  z-index: 2;
  max-width: 1160px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 32px;
  color: #fff;
}
.hero-mask h2 {
  font-size: 40px;
  line-height: 1.3;
  margin: 0 0 14px;
  letter-spacing: 3px;
}
.hero-mask p {
  margin: 0;
  font-size: 15px;
  letter-spacing: 1px;
  opacity: 0.85;
}
.types {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  margin-bottom: 20px;
}
.type-card {
  border-radius: 20px;
  padding: 30px 24px;
  color: #fff;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.type-card:hover {
  transform: translateY(-3px);
}
.type-card .el-icon {
  font-size: 26px;
}
.type-card h3 {
  margin: 10px 0 6px;
  font-size: 17px;
}
.type-card p {
  margin: 0;
  font-size: 12px;
  opacity: 0.85;
}
.self {
  background: linear-gradient(135deg, #d8c17a, #c9a252);
}
.family {
  background: linear-gradient(135deg, #b8d29a, #8fae6a);
}
.tips {
  padding: 16px;
}
.tips ol {
  margin: 0;
  padding-left: 18px;
  color: #6b7263;
  font-size: 13px;
  line-height: 2;
}
</style>
