<script setup>
import { computed, reactive, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { doctorLogin, login } from '@/assets/api'
import { clearDoctor, clearUser, setDoctor, setUser } from '@/assets/auth'
import Aurora from '@/components/Aurora.vue'

const router = useRouter()
const route = useRoute()
const auroraStops = ['#4a5c39', '#a9c47f', '#4a5c39']

const loading = ref(false)
const role = ref(route.query.role === 'doctor' ? 'doctor' : 'user')
const isDoctor = computed(() => role.value === 'doctor')

const userForm = reactive({ userId: '15642388888', password: '123456' })
const doctorForm = reactive({ docCode: 'sun', password: '123456' })

watch(
  () => route.query.role,
  (value) => {
    role.value = value === 'doctor' ? 'doctor' : 'user'
  },
)

function switchRole(next) {
  if (loading.value || role.value === next) return
  role.value = next
  router.replace({ path: '/login', query: { role: next } })
}

async function onSubmit() {
  const account = isDoctor.value ? doctorForm.docCode : userForm.userId
  const password = isDoctor.value ? doctorForm.password : userForm.password

  if (!account || !password) {
    ElMessage.warning(isDoctor.value ? '请输入医生工号和密码' : '请输入手机号码和密码')
    return
  }

  loading.value = true
  try {
    if (isDoctor.value) {
      const doctor = await doctorLogin(account, password)
      clearUser()
      setDoctor(doctor)
      ElMessage.success(`欢迎回来，${doctor.realName}医生`)
      router.replace('/admin/customers')
      return
    }

    const user = await login(account, password)
    clearDoctor()
    setUser(user)
    ElMessage.success(`欢迎回来，${user.realName}`)

    const redirect = typeof route.query.redirect === 'string' ? route.query.redirect : ''
    const safe = redirect.startsWith('/') && !redirect.startsWith('/admin') && redirect !== '/login'
    router.replace(safe ? redirect : '/home')
  } catch (e) {
    ElMessage.error(e.message || '登录失败')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="login-page">
    <Aurora
      class="login-aurora"
      :color-stops="auroraStops"
      :amplitude="1.3"
      :blend="0.75"
      :speed="0.5"
    />
    <div class="login-card">
      <div class="logo">东软体检</div>
      <p class="sub">健康预约与体检报告服务平台</p>

      <div class="role-tabs">
        <button type="button" :class="{ active: !isDoctor }" @click="switchRole('user')">
          <el-icon><User /></el-icon>
          用户登录
        </button>
        <button type="button" :class="{ active: isDoctor }" @click="switchRole('doctor')">
          <el-icon><FirstAidKit /></el-icon>
          医生登录
        </button>
      </div>

      <template v-if="!isDoctor">
        <el-input
          v-model="userForm.userId"
          size="large"
          placeholder="输入手机号码"
          :prefix-icon="'Iphone'"
          maxlength="11"
          class="field"
          name="neusoft-user-id"
          autocomplete="off"
        />
        <el-input
          v-model="userForm.password"
          size="large"
          type="password"
          placeholder="输入登录密码"
          :prefix-icon="'Lock'"
          show-password
          class="field"
          name="neusoft-user-pass"
          autocomplete="new-password"
          @keyup.enter="onSubmit"
        />

        <div class="links">
          <span @click="router.push('/register')">注册新账号</span>
          <span class="forget" @click="ElMessage.info('请联系客服 4008-XXX-XXX 重置密码')"
            >忘记密码？</span
          >
        </div>

        <button class="btn-primary" :disabled="loading" @click="onSubmit">
          {{ loading ? '登录中...' : '登 录' }}
        </button>

        <div class="demo">
          <span class="demo-label">演示账号</span>
          <span>15642388888</span>
          <span class="dot">/</span>
          <span>123456</span>
        </div>
      </template>

      <template v-else>
        <el-input
          v-model="doctorForm.docCode"
          size="large"
          placeholder="输入医生工号"
          :prefix-icon="'User'"
          class="field"
          name="neusoft-doctor-code"
          autocomplete="off"
        />
        <el-input
          v-model="doctorForm.password"
          size="large"
          type="password"
          placeholder="输入登录密码"
          :prefix-icon="'Lock'"
          show-password
          class="field"
          name="neusoft-doctor-pass"
          autocomplete="new-password"
          @keyup.enter="onSubmit"
        />

        <div class="links">
          <span class="hint-inline">账号由医院统一分配</span>
          <span class="forget" @click="ElMessage.info('请联系信息科重置工号密码')">忘记密码？</span>
        </div>

        <button class="btn-primary" :disabled="loading" @click="onSubmit">
          {{ loading ? '登录中...' : '登 录' }}
        </button>

        <div class="demo">
          <span class="demo-label">演示账号</span>
          <span>sun / 123456</span>
          <span class="dot">·</span>
          <span>zhang / 123456</span>
        </div>
      </template>

      <p class="support">东软体检 · 教学演示项目</p>
    </div>
  </div>
</template>

<style scoped>
.login-page {
  position: relative;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(160deg, #5b7440 0%, #7c9a59 48%, #a9c47f 100%);
  padding: 24px;
  overflow: hidden;
}
.login-aurora {
  position: absolute;
  inset: 0;
  z-index: 0;
}
.login-card {
  position: relative;
  z-index: 1;
  width: 420px;
  max-width: 100%;
  background: #fff;
  border-radius: 24px;
  padding: 40px 38px 30px;
  box-shadow: 0 24px 60px rgba(35, 45, 28, 0.28);
  text-align: center;
}
.logo {
  font-size: 28px;
  font-weight: 800;
  letter-spacing: 3px;
  color: #5c7442;
}
.sub {
  color: #8b927f;
  font-size: 13px;
  margin: 8px 0 24px;
}
.role-tabs {
  display: flex;
  gap: 4px;
  padding: 5px;
  background: #f2f5ea;
  border-radius: 14px;
  margin-bottom: 24px;
}
.role-tabs button {
  flex: 1;
  height: 40px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  border: none;
  border-radius: 10px;
  background: transparent;
  color: #8a9178;
  font-size: 14px;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.2s ease;
}
.role-tabs button:hover {
  color: #6b854a;
}
.role-tabs button.active {
  background: #fff;
  color: #5b7440;
  font-weight: 600;
  box-shadow: 0 2px 10px rgba(91, 116, 64, 0.14);
}
.field {
  margin-bottom: 14px;
}
.links {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 13px;
  color: #8fae6a;
  margin: 2px 0 18px;
  cursor: pointer;
}
.links .hint-inline {
  color: #a3aa97;
  cursor: default;
}
.forget {
  color: #8b927f;
}
.demo {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
  gap: 6px;
  margin-top: 18px;
  padding: 10px 12px;
  border-radius: 12px;
  background: #f4f7ed;
  color: #6b7263;
  font-size: 12.5px;
}
.demo-label {
  color: #8a9178;
}
.demo .dot {
  opacity: 0.45;
}
.support {
  margin-top: 20px;
  font-size: 12px;
  color: #a3aa97;
}
</style>
