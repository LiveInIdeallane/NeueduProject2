<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import NavBar from '@/components/NavBar.vue'
import { cancelOrder, getOrdersByUser } from '@/assets/api'
import { getUser } from '@/assets/auth'

const router = useRouter()
const user = getUser()
const list = ref([])
const loading = ref(true)

async function load() {
  loading.value = true
  list.value = await getOrdersByUser(user.userId)
  loading.value = false
}

onMounted(load)

async function cancel(order) {
  try {
    await ElMessageBox.confirm('确定要取消该预约吗？', '取消预约', {
      confirmButtonText: '确定取消',
      cancelButtonText: '再想想',
      type: 'warning',
    })
  } catch {
    return
  }
  await cancelOrder(order.orderId)
  ElMessage.success('已取消预约')
  load()
}
</script>

<template>
  <div>
    <NavBar title="我的预约" />
    <div class="narrow list-gap">
      <div v-if="loading" style="height: 160px"></div>
      <el-empty v-else-if="!list.length" description="暂无预约记录" />
      <div v-for="o in list" :key="o.orderId" class="order card">
        <div class="o-top">
          <span class="o-title">{{ o.hospitalName }}</span>
          <span class="cancel" v-if="o.state === 1" @click="cancel(o)">取消预约</span>
          <span v-else class="tag">已归档</span>
        </div>
        <div class="o-setmeal">{{ o.setmealName }}</div>
        <div class="o-meta">
          <span>体检日期：{{ o.orderDate }}</span>
          <span class="price">¥{{ o.price }}</span>
        </div>
        <div class="o-meta text-sub">
          <span>订单编号：{{ o.orderId }}</span>
          <span @click="router.push(`/reports/${o.orderId}`)" class="link">查看报告 ›</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.order {
  padding: 16px;
}
.o-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}
.o-title {
  font-weight: 700;
  font-size: 14px;
}
.cancel {
  color: #c99a4e;
  font-size: 12px;
  cursor: pointer;
}
.o-setmeal {
  font-size: 13px;
  color: #6b7263;
  margin-bottom: 10px;
}
.o-meta {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #6b7263;
  line-height: 1.9;
}
.link {
  color: var(--primary-dark);
  cursor: pointer;
}
</style>
