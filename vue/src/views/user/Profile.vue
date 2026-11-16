<script setup>
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { clearUser, getUser } from '@/assets/auth'

const router = useRouter()
const user = getUser()

const menus = [
  { label: '我的预约', icon: 'Calendar', path: '/orders' },
  { label: '我的服务', icon: 'Service', path: '/reports' },
  { label: '我的医生', icon: 'User', path: '/reports' },
  { label: '问诊订单', icon: 'ChatDotRound', path: '/reports' },
  { label: '商城订单', icon: 'ShoppingCart', path: '/appointment/type' },
]

function open(menu) {
  if (menu.path) router.push(menu.path)
}

function logout() {
  clearUser()
  ElMessage.success('已退出登录')
  router.replace('/login')
}
</script>

<template>
  <div>
    <div class="profile-head">
      <div class="avatar">{{ user?.realName?.slice(0, 1) || 'U' }}</div>
      <div>
        <div class="p-name">{{ user?.realName }}</div>
        <div class="p-phone">账号：{{ user?.userId }}</div>
      </div>
    </div>

    <div class="narrow">
      <div class="card menu">
        <div v-for="m in menus" :key="m.label" class="menu-item" @click="open(m)">
          <el-icon class="m-icon"><component :is="m.icon" /></el-icon>
          <span class="m-label">{{ m.label }}</span>
          <el-icon class="m-arrow"><ArrowRight /></el-icon>
        </div>
        <div class="menu-item logout" @click="logout">
          <el-icon class="m-icon"><SwitchButton /></el-icon>
          <span class="m-label">退出登录</span>
          <el-icon class="m-arrow"><ArrowRight /></el-icon>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.profile-head {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 24px 20px;
  background: linear-gradient(120deg, #5c7442, #8fae6a);
  color: #fff;
}
.avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.25);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  font-weight: 700;
}
.p-name {
  font-size: 19px;
  font-weight: 700;
}
.p-phone {
  font-size: 12px;
  opacity: 0.85;
  margin-top: 4px;
}
.menu {
  overflow: hidden;
}
.menu-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 15px 16px;
  border-bottom: 1px solid #f2f4ec;
  cursor: pointer;
  font-size: 14px;
}
.menu-item:last-child {
  border-bottom: none;
}
.m-icon {
  color: var(--primary-dark);
  font-size: 18px;
}
.m-label {
  flex: 1;
}
.m-arrow {
  color: #cbd1c1;
}
.logout .m-label,
.logout .m-icon {
  color: #c97b6b;
}
</style>
