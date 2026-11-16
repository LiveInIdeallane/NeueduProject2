<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import NavBar from '@/components/NavBar.vue'
import { getSetmeals } from '@/assets/api'
import { appointment, saveAppointment } from '@/assets/appointment'

const router = useRouter()
const setmeals = ref([])
const activeType = ref(1)
const loading = ref(true)

const list = computed(() => setmeals.value.filter((s) => s.type === activeType.value))

onMounted(async () => {
  setmeals.value = await getSetmeals()
  loading.value = false
})

function choose(s) {
  appointment.smId = s.smId
  saveAppointment()
  router.push('/appointment/date')
}
</script>

<template>
  <div>
    <NavBar title="选择体检套餐" />
    <div class="tabs">
      <div class="tab" :class="{ active: activeType === 1 }" @click="activeType = 1">男士套餐</div>
      <div class="tab" :class="{ active: activeType === 0 }" @click="activeType = 0">女士套餐</div>
    </div>

    <div class="narrow list-gap">
      <div v-if="loading" style="height: 160px"></div>
      <div v-for="s in list" :key="s.smId" class="setmeal card" @click="choose(s)">
        <div class="sm-main">
          <div class="sm-name">{{ s.name }}</div>
          <div class="text-sub">{{ s.desc }}</div>
          <div class="tags">
            <span v-for="it in s.items" :key="it" class="tag">{{ it }}</span>
          </div>
        </div>
        <div class="sm-right">
          <div class="price">¥{{ s.price }}</div>
          <span class="detail">详情 ›</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.tabs {
  display: flex;
  max-width: 780px;
  margin: 0 auto;
  background: #fff;
  border-bottom: 1px solid var(--border);
}
.tab {
  flex: 1;
  text-align: center;
  padding: 13px 0;
  font-size: 14px;
  color: var(--text-sub);
  cursor: pointer;
  position: relative;
}
.tab.active {
  color: var(--primary-dark);
  font-weight: 700;
}
.tab.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 42px;
  height: 3px;
  border-radius: 3px;
  background: var(--primary);
}
.setmeal {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  padding: 16px;
  cursor: pointer;
}
.setmeal:hover {
  box-shadow: 0 6px 18px rgba(70, 78, 60, 0.12);
}
.sm-name {
  font-weight: 700;
  margin-bottom: 5px;
}
.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-top: 8px;
}
.sm-right {
  text-align: right;
  flex-shrink: 0;
}
.sm-right .price {
  font-size: 18px;
}
.detail {
  display: inline-block;
  margin-top: 26px;
  font-size: 12px;
  color: var(--primary-dark);
}
</style>
