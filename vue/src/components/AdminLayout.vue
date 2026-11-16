<script setup>
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { clearDoctor, getDoctor } from '@/assets/auth'

const router = useRouter()
const doctor = getDoctor()

function logout() {
  clearDoctor()
  ElMessage.success('已退出登录')
  router.replace({ path: '/login', query: { role: 'doctor' } })
}
</script>

<template>
  <div class="admin-root">
    <header class="admin-header">
      <div class="brand"><span class="software">Neusoft</span> 东软体检报告管理系统</div>
      <div class="doctor">
        医生：{{ doctor?.realName }}
        <el-button link type="primary" style="margin-left: 12px" @click="logout">退出</el-button>
      </div>
    </header>
    <router-view />
  </div>
</template>
