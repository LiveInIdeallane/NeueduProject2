<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getUser } from '@/assets/auth'

const route = useRoute()
const router = useRouter()
const user = getUser()

const navs = [
  { label: '云医院', path: '/home' },
  { label: '体检预约', path: '/appointment/type' },
  { label: '健康档案', path: '/reports' },
  { label: '我的预约', path: '/orders' },
]

const active = computed(() => {
  const p = route.path
  if (p.startsWith('/appointment')) return '/appointment/type'
  if (p.startsWith('/reports')) return '/reports'
  if (p.startsWith('/orders')) return '/orders'
  return '/home'
})
</script>

<template>
  <div class="web-root">
    <header class="site-header">
      <div class="container header-inner">
        <div class="site-brand" @click="router.push('/home')">
          东软体检<span>·</span>健康预约平台
        </div>
        <nav class="site-nav">
          <router-link
            v-for="n in navs"
            :key="n.path"
            :to="n.path"
            :class="{ 'router-link-active': active === n.path }"
          >
            {{ n.label }}
          </router-link>
        </nav>
        <div class="site-user">
          <template v-if="user">
            <el-icon><User /></el-icon>
            <span>{{ user.realName }}</span>
            <el-button link type="primary" @click="router.push('/profile')">个人中心</el-button>
          </template>
          <template v-else>
            <el-button link type="primary" @click="router.push('/login')">登录</el-button>
            <el-button link @click="router.push('/register')">注册</el-button>
          </template>
        </div>
      </div>
    </header>

    <main class="site-main">
      <router-view />
    </main>

    <footer class="site-footer">
      东软体检 · 健康预约平台　|　客服电话 4008-XXX-XXX　|　本页面为教学演示项目
    </footer>
  </div>
</template>
