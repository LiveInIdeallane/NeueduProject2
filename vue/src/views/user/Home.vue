<script setup>
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import Aurora from '@/components/Aurora.vue'

const router = useRouter()
const auroraStops = ['#4a5c39', '#9dbd7a', '#4a5c39']

const services = [
  { icon: 'ChatDotRound', label: '免费咨询' },
  { icon: 'VideoCamera', label: '网络问诊' },
  { icon: 'FirstAidKit', label: 'e心门诊' },
  { icon: 'Odometer', label: '慢病管理' },
  { icon: 'House', label: '上门护理' },
  { icon: 'Calendar', label: '团检预约' },
]

const doctors = [
  { name: '刘长胜', title: '主任医师', color: '#a3bf86' },
  { name: '孙晨', title: '主任医师', color: '#c9a882' },
  { name: '吕文达', title: '主任医师', color: '#a8c48f' },
  { name: '李桂英', title: '主任医师', color: '#b6a98f' },
  { name: '张石凡', title: '副主任医师', color: '#cdbc85' },
  { name: '赵桂凤', title: '副主任医师', color: '#9dbd95' },
  { name: '李玉', title: '主任医师', color: '#c39a8f' },
  { name: '吴晓芳', title: '主任医师', color: '#aab894' },
]

const articles = [
  { title: '查出肺结节，我是不是要得肺癌？肺结节一定会变成肺癌吗？', hot: 4512 },
  { title: '体检发现甲状腺结节，怎么办？日常需要注意什么？', hot: 3609 },
]

function notReady(name) {
  ElMessage.info(`「${name}」为演示入口，暂未开放`)
}
</script>

<template>
  <div class="home page-container">
    <div class="home-header">
      <div class="hospital-name">
        沈阳云医院
        <el-icon><ArrowDown /></el-icon>
      </div>
      <el-icon class="msg"><Message /></el-icon>
    </div>

    <div class="banner">
      <Aurora class="banner-aurora" :color-stops="auroraStops" :amplitude="1.2" :blend="0.65" :speed="0.6" />
      <div class="banner-overlay"></div>
      <div class="banner-text">
        <h3>健康生活</h3>
        <p>从一次体检开始</p>
        <span @click="router.push('/appointment/type')">立即预约体检 →</span>
      </div>
      <div class="banner-art">🩺</div>
    </div>

    <div class="section services">
      <div v-for="s in services" :key="s.label" class="service" @click="notReady(s.label)">
        <div class="service-icon"><el-icon><component :is="s.icon" /></el-icon></div>
        <span>{{ s.label }}</span>
      </div>
    </div>

    <div class="section">
      <div class="report-card card" @click="router.push('/reports')">
        <div>
          <div class="report-title">我的健康报告</div>
          <div class="text-sub">随时随地方便查看体检报告</div>
        </div>
        <el-button type="primary" round size="small">立即查看</el-button>
      </div>
    </div>

    <div class="section">
      <div class="section-title"><span>推荐医师</span></div>
      <div class="doctors">
        <div v-for="d in doctors" :key="d.name + d.title" class="doctor" @click="notReady('医师咨询')">
          <div class="avatar" :style="{ background: d.color }">{{ d.name.slice(-2) }}</div>
          <div class="d-name">{{ d.name }}</div>
          <div class="d-title">{{ d.title }}</div>
        </div>
      </div>
    </div>

    <div class="section">
      <div class="section-title"><span>健康评测</span><span class="more">更多</span></div>
      <div class="assess">
        <div class="assess-item g1"><span>食物嘌呤查询</span></div>
        <div class="assess-item g2"><span>HRA 健康风险评估</span></div>
      </div>
    </div>

    <div class="section">
      <div class="section-title"><span>健康资讯</span><span class="more">更多</span></div>
      <div class="list-gap">
        <div v-for="a in articles" :key="a.title" class="article card">
          <div class="a-thumb">📰</div>
          <div class="a-body">
            <div class="a-title">{{ a.title }}</div>
            <div class="a-hot">🔥 {{ a.hot }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.home-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 2px 4px 22px;
}
.hospital-name {
  font-size: 21px;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 4px;
}
.msg {
  font-size: 22px;
  color: #7c8373;
  cursor: pointer;
}
.banner {
  position: relative;
  margin: 0;
  border-radius: 24px;
  padding: 48px 46px;
  min-height: 240px;
  background: #3f4f31;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  overflow: hidden;
  box-shadow: 0 18px 40px rgba(70, 85, 50, 0.16);
}
.banner-aurora {
  position: absolute;
  inset: 0;
  z-index: 0;
}
.banner-overlay {
  position: absolute;
  inset: 0;
  z-index: 1;
  background: linear-gradient(100deg, rgba(45, 55, 38, 0.58), rgba(45, 55, 38, 0.06));
}
.banner-text {
  position: relative;
  z-index: 2;
}
.banner-art {
  position: relative;
  z-index: 2;
}
.banner-text h3 {
  margin: 0 0 10px;
  font-size: 34px;
  letter-spacing: 1px;
}
.banner-text p {
  margin: 0 0 22px;
  opacity: 0.88;
  font-size: 15px;
  letter-spacing: 1px;
}
.banner-text span {
  font-size: 13px;
  background: rgba(255, 255, 255, 0.22);
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 9px 20px;
  border-radius: 999px;
  cursor: pointer;
  transition: background 0.2s ease;
}
.banner-text span:hover {
  background: rgba(255, 255, 255, 0.32);
}
.banner-art {
  font-size: 96px;
  opacity: 0.92;
}
.services {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 26px 12px;
}
.service {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  font-size: 13.5px;
  color: #5a6152;
  cursor: pointer;
  transition: transform 0.2s ease;
}
.service:hover {
  transform: translateY(-2px);
}
.service-icon {
  width: 60px;
  height: 60px;
  border-radius: 18px;
  background: var(--primary-light);
  color: var(--primary-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  box-shadow: inset 0 0 0 1px #dfe8d2;
}
.report-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 26px 30px;
  background: linear-gradient(120deg, #f0f4e6, #f8faf2);
}
.report-title {
  font-weight: 600;
  margin-bottom: 4px;
}
.doctors {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}
.doctor {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 18px;
  text-align: left;
  cursor: pointer;
  font-size: 12px;
  background: #fff;
  border: 1px solid #eef1e5;
  border-radius: 16px;
  transition: box-shadow 0.2s ease, transform 0.2s ease;
}
.doctor:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 26px rgba(143, 174, 106, 0.14);
}
.avatar {
  width: 52px;
  height: 52px;
  border-radius: 50%;
  flex-shrink: 0;
  color: #fff;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.d-name {
  font-weight: 600;
  font-size: 14px;
  color: #404838;
}
.d-title {
  color: var(--text-sub);
  margin-top: 3px;
}
.assess {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}
.assess-item {
  height: 112px;
  border-radius: 18px;
  color: #fff;
  display: flex;
  align-items: flex-end;
  padding: 22px;
  font-size: 15px;
  font-weight: 600;
  letter-spacing: 0.5px;
  box-shadow: 0 12px 26px rgba(143, 174, 106, 0.14);
}
.g1 {
  background: linear-gradient(135deg, #a7c17e, #8fae6a);
}
.g2 {
  background: linear-gradient(135deg, #cfa06a, #c88fa6);
}
.article {
  display: flex;
  gap: 16px;
  padding: 18px 20px;
  align-items: center;
}
.a-thumb {
  width: 76px;
  height: 66px;
  border-radius: 14px;
  background: #f0f3e8;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 30px;
  flex-shrink: 0;
}
.a-title {
  font-size: 14px;
  line-height: 1.6;
  color: #404838;
}
.a-hot {
  font-size: 11px;
  color: #c99a4e;
  margin-top: 6px;
}
</style>
