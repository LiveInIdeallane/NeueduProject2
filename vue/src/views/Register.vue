<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { register } from '@/assets/api'
import { clearDoctor, setUser } from '@/assets/auth'

const router = useRouter()
const loading = ref(false)
const formRef = ref()
const form = reactive({
  userId: '',
  realName: '',
  birthday: '',
  sex: 1,
  identityCard: '',
  password: '',
  confirm: '',
})

const rules = {
  userId: [
    { required: true, message: '请输入手机号码', trigger: 'blur' },
    { pattern: /^1\d{10}$/, message: '请输入正确的手机号码', trigger: 'blur' },
  ],
  realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
  birthday: [{ required: true, message: '请选择出生日期', trigger: 'change' }],
  identityCard: [
    { required: true, message: '请输入身份证号', trigger: 'blur' },
    { pattern: /^\d{17}[\dXx]$/, message: '身份证号格式不正确', trigger: 'blur' },
  ],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  confirm: [
    {
      validator: (_rule, value, cb) =>
        value === form.password ? cb() : cb(new Error('两次输入的密码不一致')),
      trigger: 'blur',
    },
  ],
}

async function onSubmit() {
  try {
    await formRef.value.validate()
  } catch {
    return
  }
  loading.value = true
  try {
    const { confirm, ...payload } = form
    const user = await register(payload)
    clearDoctor()
    setUser(user)
    ElMessage.success('注册成功')
    router.replace('/home')
  } catch (e) {
    ElMessage.error(e.message || '注册失败')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="register-page">
    <div class="reg-card">
      <div class="nav-bar">
        <div class="back" @click="router.back()">
          <el-icon><ArrowLeft /></el-icon>
        </div>
        <div class="nav-title">注册</div>
      </div>

      <div class="head">
        <h2>欢迎注册熙心健康</h2>
        <p class="text-sub">真实信息用于查看体检报告</p>
      </div>

      <el-form ref="formRef" :model="form" :rules="rules" label-position="top">
        <el-form-item label="手机号码" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入手机号码" maxlength="11" />
        </el-form-item>
        <el-form-item label="真实姓名" prop="realName">
          <el-input v-model="form.realName" placeholder="真实姓名用于查看体检报告" />
        </el-form-item>
        <el-form-item label="生日" prop="birthday">
          <el-date-picker
            v-model="form.birthday"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="年 / 月 / 日"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="form.sex">
            <el-radio :value="1"
              ><el-icon><Male /></el-icon> 男</el-radio
            >
            <el-radio :value="0"
              ><el-icon><Female /></el-icon> 女</el-radio
            >
          </el-radio-group>
        </el-form-item>
        <el-form-item label="身份证号" prop="identityCard">
          <el-input v-model="form.identityCard" placeholder="请输入身份证号" maxlength="18" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
            v-model="form.password"
            type="password"
            show-password
            placeholder="请输入密码"
          />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirm">
          <el-input
            v-model="form.confirm"
            type="password"
            show-password
            placeholder="请再次输入密码"
          />
        </el-form-item>
      </el-form>

      <button class="btn-primary" :disabled="loading" @click="onSubmit">
        {{ loading ? '提交中...' : '完成' }}
      </button>
    </div>
  </div>
</template>

<style scoped>
.register-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  padding: 40px 20px;
}
.reg-card {
  width: 460px;
  max-width: 100%;
  background: #fff;
  border-radius: 24px;
  padding: 14px 0 32px;
  box-shadow: 0 24px 60px rgba(70, 85, 50, 0.16);
  overflow: hidden;
}
.head {
  padding: 26px 30px 8px;
}
.head h2 {
  margin: 0 0 6px;
  font-size: 22px;
}
.reg-card :deep(.el-form) {
  padding: 0 22px;
}
.reg-card :deep(.el-form-item__label) {
  font-weight: 600;
}
.reg-card .btn-primary {
  width: calc(100% - 44px);
  margin: 10px 22px 0;
}
</style>
