<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import NavBar from '@/components/NavBar.vue'
import { getHospitals } from '@/assets/api'
import { appointment, saveAppointment } from '@/assets/appointment'

const router = useRouter()
const hospitals = ref([])
const loading = ref(true)

onMounted(async () => {
  hospitals.value = await getHospitals()
  loading.value = false
})

function choose(h) {
  appointment.hpId = h.hpId
  saveAppointment()
  router.push('/appointment/setmeal')
}

function call(h) {
  ElMessage.success(`正在拨打 ${h.telephone}`)
}
</script>

<template>
  <div>
    <NavBar title="请您选择体检机构" />
    <div class="narrow list-gap">
      <div v-loading="loading" v-if="loading" style="height: 200px"></div>
      <div v-for="h in hospitals" :key="h.hpId" class="hospital card" @click="choose(h)">
        <div class="h-head">
          <span class="h-name">{{ h.name }}</span>
          <el-icon><ArrowRight /></el-icon>
        </div>
        <div class="h-line">营业时间：{{ h.businessHours }}</div>
        <div class="h-line">采血截止：{{ h.deadline }}</div>
        <div class="h-line">电话：{{ h.telephone }}</div>
        <div class="h-line">地址：{{ h.address }}</div>
        <div class="h-actions" @click.stop>
          <el-button round size="small" :icon="'Phone'" @click="call(h)">联系我们</el-button>
          <el-button round size="small" type="primary" :icon="'Location'" @click="call(h)">查找位置</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hospital {
  padding: 16px;
  cursor: pointer;
}
.hospital:hover {
  box-shadow: 0 6px 18px rgba(70, 78, 60, 0.12);
}
.h-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: 700;
  font-size: 15px;
  margin-bottom: 10px;
}
.h-name {
  color: #3b4238;
}
.h-line {
  font-size: 12px;
  color: var(--text-sub);
  line-height: 1.9;
}
.h-actions {
  margin-top: 12px;
  display: flex;
  gap: 8px;
}
</style>
