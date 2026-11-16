import { reactive } from 'vue'

const KEY = 'tj_appointment'

function load() {
  try {
    return JSON.parse(sessionStorage.getItem(KEY) || 'null')
  } catch {
    return null
  }
}

const saved = load()

// 预约流程中临时选择：预约类型(1本人/2家属) -> 机构 -> 套餐 -> 日期
export const appointment = reactive({
  type: saved?.type ?? 1,
  hpId: saved?.hpId ?? null,
  smId: saved?.smId ?? null,
  orderDate: saved?.orderDate ?? '',
})

export function saveAppointment() {
  sessionStorage.setItem(KEY, JSON.stringify(appointment))
}

export function resetAppointment() {
  appointment.type = 1
  appointment.hpId = null
  appointment.smId = null
  appointment.orderDate = ''
  sessionStorage.removeItem(KEY)
}
