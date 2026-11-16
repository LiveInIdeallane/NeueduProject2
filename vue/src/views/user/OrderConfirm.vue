<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import NavBar from '@/components/NavBar.vue'
import { createOrder, getHospital, getSetmeal } from '@/assets/api'
import { appointment } from '@/assets/appointment'
import { getUser } from '@/assets/auth'

const router = useRouter()
const user = getUser()
const hospital = ref(null)
const setmeal = ref(null)
const loading = ref(true)
const paying = ref(false)

onMounted(async () => {
  if (!appointment.hpId || !appointment.smId || !appointment.orderDate) {
    ElMessage.warning('预约信息不完整，请重新选择')
    router.replace('/appointment/hospital')
    return
  }
  hospital.value = await getHospital(appointment.hpId)
  setmeal.value = await getSetmeal(appointment.smId)
  loading.value = false
})

async function pay() {
  try {
    await ElMessageBox.confirm(`确认支付 ¥${setmeal.value.price} 完成预约？`, '确认支付', {
      confirmButtonText: '确认支付',
      cancelButtonText: '取消',
      type: 'warning',
    })
  } catch {
    return
  }
  paying.value = true
  try {
    const order = await createOrder({
      orderDate: appointment.orderDate,
      userId: user.userId,
      hpId: appointment.hpId,
      smId: appointment.smId,
    })
    router.replace({ path: '/appointment/success', query: { orderId: order.orderId } })
  } catch (e) {
    ElMessage.error(e.message || '预约失败')
  } finally {
    paying.value = false
  }
}
</script>

<template>
  <div>
    <NavBar title="确认你的订单" />
    <div v-if="!loading" class="narrow list-gap">
      <div class="card block">
        <div class="section-title"><span>体检人信息</span></div>
        <div class="row"><span class="k">姓名</span><span>{{ user?.realName }}</span></div>
        <div class="row"><span class="k">证件号码</span><span>{{ user?.identityCard }}</span></div>
        <div class="row"><span class="k">出生日期</span><span>{{ user?.birthday }}</span></div>
        <div class="row"><span class="k">手机号码</span><span>{{ user?.userId }}</span></div>
      </div>

      <div class="card block">
        <div class="section-title"><span>体检日期</span></div>
        <div class="row"><span>{{ appointment.orderDate }}</span></div>
      </div>

      <div class="card block">
        <div class="section-title"><span>体检机构</span></div>
        <div class="row bold">{{ hospital?.name }}</div>
        <div class="row sub">营业时间：{{ hospital?.businessHours }}</div>
        <div class="row sub">{{ hospital?.deadline }}</div>
        <div class="row sub">机构电话：{{ hospital?.telephone }}</div>
      </div>

      <div class="card block">
        <div class="section-title"><span>体检套餐</span></div>
        <div class="row bold">{{ setmeal?.name }}</div>
        <div class="row sub">{{ setmeal?.desc }}</div>
      </div>
    </div>

    <div class="pay-bar">
      <div class="pay-total">
        实付款：<span class="price">¥{{ setmeal?.price ?? '--' }}</span>
      </div>
      <button class="btn-primary pay-btn" :disabled="paying || loading" @click="pay">
        {{ paying ? '处理中...' : '确认支付' }}
      </button>
    </div>
  </div>
</template>

<style scoped>
.block {
  padding: 16px;
}
.row {
  display: flex;
  font-size: 13px;
  color: #404838;
  line-height: 2;
}
.row .k {
  width: 74px;
  color: var(--text-sub);
}
.row.bold {
  font-weight: 700;
}
.row.sub {
  color: var(--text-sub);
  font-size: 12px;
}
.pay-bar {
  display: flex;
  align-items: center;
  gap: 12px;
  max-width: 780px;
  margin: 0 auto;
  padding: 12px 24px;
  background: #fff;
  border-top: 1px solid var(--border);
}
.pay-total {
  flex: 1;
  font-size: 14px;
}
.pay-btn {
  width: 150px;
  height: 42px;
  font-size: 15px;
}
</style>
