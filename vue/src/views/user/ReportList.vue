<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import NavBar from '@/components/NavBar.vue'
import { getReportsByUser } from '@/assets/api'
import { getUser } from '@/assets/auth'

const router = useRouter()
const user = getUser()
const list = ref([])
const loading = ref(true)

onMounted(async () => {
  list.value = await getReportsByUser(user.userId)
  loading.value = false
})
</script>

<template>
  <div>
    <NavBar title="健康档案" />
    <div class="banner">
      <div>
        <h3>免费解读体检报告</h3>
        <p>1 对 1 咨询，快速解读</p>
        <el-button round size="small" @click="ElMessage.info('建议咨询在线医生')">点击免费咨询 ›</el-button>
      </div>
      <div class="art">👩‍⚕️</div>
    </div>

    <div class="narrow list-gap">
      <div v-if="loading" style="height: 160px"></div>
      <el-empty v-else-if="!list.length" description="暂无体检报告" />
      <div v-for="o in list" :key="o.orderId" class="report card" @click="router.push(`/reports/${o.orderId}`)">
        <div class="r-icon">📄</div>
        <div class="r-body">
          <div class="r-title">{{ o.orderDate }} 体检报告</div>
          <div class="text-sub">{{ o.hospitalName }}</div>
        </div>
        <el-icon class="r-arrow"><ArrowRight /></el-icon>
      </div>
    </div>
  </div>
</template>

<style scoped>
.banner {
  max-width: 780px;
  margin: 14px auto;
  border-radius: 14px;
  padding: 20px;
  background: linear-gradient(120deg, #f0f4e6, #e8eedb);
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.banner h3 {
  margin: 0 0 6px;
  color: #5c7442;
}
.banner p {
  margin: 0 0 12px;
  font-size: 12px;
  color: #6f7a64;
}
.art {
  font-size: 54px;
}
.report {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  cursor: pointer;
}
.r-icon {
  font-size: 26px;
}
.r-body {
  flex: 1;
}
.r-title {
  font-weight: 600;
  margin-bottom: 4px;
}
.r-arrow {
  color: #cbd1c1;
}
</style>
