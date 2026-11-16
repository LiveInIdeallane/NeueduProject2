<script setup>
import { computed, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import NavBar from '@/components/NavBar.vue'
import { appointment, saveAppointment } from '@/assets/appointment'

const router = useRouter()
const today = new Date()
const year = ref(today.getFullYear())
const month = ref(today.getMonth())
const selected = ref(appointment.orderDate || '')

const weekdays = ['日', '一', '二', '三', '四', '五', '六']

const monthLabel = computed(() => `${year.value}年${month.value + 1}月`)

const days = computed(() => {
  const first = new Date(year.value, month.value, 1)
  const start = first.getDay()
  const total = new Date(year.value, month.value + 1, 0).getDate()
  const cells = []
  for (let i = 0; i < start; i++) cells.push(null)
  for (let d = 1; d <= total; d++) {
    const date = new Date(year.value, month.value, d)
    const iso = `${year.value}-${String(month.value + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`
    const isPast = date < new Date(today.getFullYear(), today.getMonth(), today.getDate())
    const week = date.getDay()
    const full = (week === 0 || week === 6) && d % 3 === 0
    cells.push({ d, iso, isPast, full })
  }
  return cells
})

function shift(step) {
  const m = month.value + step
  const date = new Date(year.value, m, 1)
  year.value = date.getFullYear()
  month.value = date.getMonth()
}

function pick(cell) {
  if (!cell || cell.isPast || cell.full) return
  selected.value = cell.iso
}

function next() {
  if (!selected.value) {
    ElMessage.warning('请选择体检日期')
    return
  }
  appointment.orderDate = selected.value
  saveAppointment()
  router.push('/appointment/confirm')
}
</script>

<template>
  <div>
    <NavBar title="选择体检日期" />
    <div class="calendar card">
      <div class="cal-head">
        <el-icon class="arrow" @click="shift(-1)"><ArrowLeft /></el-icon>
        <span class="cal-title">{{ monthLabel }}</span>
        <el-icon class="arrow" @click="shift(1)"><ArrowRight /></el-icon>
      </div>

      <div class="week">
        <span v-for="w in weekdays" :key="w">{{ w }}</span>
      </div>

      <div class="days">
        <template v-for="(cell, i) in days" :key="i">
          <div class="cell" v-if="!cell"></div>
          <div
            v-else
            class="cell day"
            :class="{ disabled: cell.isPast || cell.full, active: selected === cell.iso }"
            @click="pick(cell)"
          >
            <span class="num">{{ cell.d }}</span>
            <span v-if="cell.full" class="label full">满</span>
            <span v-else-if="cell.isPast" class="label">已过</span>
            <span v-else class="label ok">余200</span>
          </div>
        </template>
      </div>
    </div>

    <div class="footer">
      <el-button type="primary" size="large" style="width: 100%" @click="next">下一步</el-button>
    </div>
  </div>
</template>

<style scoped>
.calendar {
  max-width: 560px;
  margin: 14px auto;
  padding: 16px;
}
.cal-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}
.cal-title {
  font-weight: 700;
}
.arrow {
  cursor: pointer;
  color: #8b927f;
  font-size: 18px;
}
.week {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  text-align: center;
  font-size: 12px;
  color: var(--text-sub);
  margin-bottom: 6px;
}
.days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 3px;
}
.cell {
  height: 50px;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: 14px;
}
.day {
  cursor: pointer;
}
.day:hover:not(.disabled) {
  background: var(--primary-light);
}
.day.active {
  background: var(--primary);
  color: #fff;
}
.day.disabled {
  color: #cbd1c1;
  cursor: not-allowed;
}
.num {
  font-weight: 600;
}
.label {
  font-size: 10px;
  color: #c4cbb9;
  transform: scale(0.9);
}
.label.ok {
  color: #8fae6a;
}
.label.full {
  color: #c99a4e;
}
.day.active .label {
  color: rgba(255, 255, 255, 0.85);
}
.footer {
  max-width: 560px;
  margin: 0 auto;
  padding: 0 24px 24px;
}
</style>
