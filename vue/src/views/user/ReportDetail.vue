<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import NavBar from '@/components/NavBar.vue'
import { getReportByOrder } from '@/assets/api'

const route = useRoute()
const active = ref('conclusion')
const loading = ref(true)
const data = ref({ order: null, groups: [], conclusions: [] })

onMounted(async () => {
  data.value = await getReportByOrder(route.params.orderId)
  loading.value = false
})

const abnormal = computed(() =>
  data.value.groups.flatMap((g) => g.items.filter((it) => it.isError).map((it) => ({ ...it, group: g.ciName }))),
)
</script>

<template>
  <div>
    <NavBar :title="data.order ? `${data.order.orderDate}体检报告` : '体检报告'" />

    <div class="tabs">
      <div class="tab" :class="{ active: active === 'conclusion' }" @click="active = 'conclusion'">总检结论</div>
      <div class="tab" :class="{ active: active === 'detail' }" @click="active = 'detail'">报告详情</div>
    </div>

    <div v-if="loading" style="height: 200px"></div>

    <template v-else>
      <div v-if="active === 'conclusion'" class="section narrow">
        <div class="block">
          <div class="block-title">异常项</div>
          <div v-if="!abnormal.length" class="text-sub">本次体检未发现明显异常</div>
          <div v-for="(it, i) in abnormal" :key="i" class="ab-row">
            <div class="ab-name"><span class="dot">异</span>{{ it.name }}</div>
            <div class="ab-value">{{ it.value }} <span class="text-sub">{{ it.unit }}</span></div>
            <div class="ab-range">{{ it.normalValueString }}</div>
          </div>
        </div>

        <div class="block">
          <div class="concl-title">一、尊贵的顾客，您本次体检结论如下：</div>
          <ol class="concl-list">
            <li v-for="c in data.conclusions" :key="c.orId">{{ c.title }}</li>
            <li v-if="!data.conclusions.length" class="text-sub">暂未生成总检结论</li>
          </ol>
        </div>

        <div class="block">
          <div class="concl-title">二、尊贵的顾客，您本次体检建议信息如下：</div>
          <div v-for="c in data.conclusions" :key="'s' + c.orId" class="advice">
            <div class="advice-title">{{ c.title }}</div>
            <p>{{ c.content }}</p>
          </div>
        </div>
      </div>

      <div v-else class="section narrow">
        <div v-for="g in data.groups" :key="g.cirId" class="block">
          <div class="block-title">{{ g.ciName }}</div>
          <div v-for="(it, i) in g.items" :key="i" class="item-row">
            <span class="i-name">
              <span v-if="it.isError" class="dot">异</span>{{ it.name }}
            </span>
            <span class="i-value">{{ it.value }} <span class="text-sub">{{ it.unit }}</span></span>
            <span class="i-range">{{ it.normalValueString }}</span>
          </div>
          <div v-if="!g.items.length" class="text-sub">暂无数据</div>
        </div>
        <el-empty v-if="!data.groups.length" description="暂无报告详情" />
      </div>
    </template>
  </div>
</template>

<style scoped>
.tabs {
  display: flex;
  max-width: 780px;
  margin: 0 auto;
  border-bottom: 1px solid var(--border);
  background: #fff;
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
  left: 50%;
  bottom: 0;
  transform: translateX(-50%);
  width: 40px;
  height: 3px;
  border-radius: 3px;
  background: var(--primary);
}
.block {
  background: #fff;
  border-radius: 12px;
  padding: 14px 16px;
  margin-bottom: 12px;
  box-shadow: 0 2px 10px rgba(70, 78, 60, 0.06);
}
.block-title {
  font-weight: 700;
  margin-bottom: 10px;
  padding-left: 8px;
  border-left: 3px solid var(--primary);
}
.ab-row {
  padding: 10px 0;
  border-bottom: 1px dashed #eef1e5;
}
.ab-row:last-child {
  border-bottom: none;
}
.ab-name {
  font-size: 13px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 6px;
}
.ab-value {
  margin: 4px 0;
  color: var(--danger);
  font-weight: 600;
}
.ab-range {
  font-size: 12px;
  color: var(--text-sub);
}
.dot {
  display: inline-block;
  width: 16px;
  height: 16px;
  line-height: 16px;
  text-align: center;
  border-radius: 4px;
  background: var(--danger);
  color: #fff;
  font-size: 10px;
  margin-right: 4px;
}
.concl-title {
  font-weight: 700;
  color: var(--primary-dark);
  margin-bottom: 10px;
}
.concl-list {
  margin: 0;
  padding-left: 20px;
  color: #404838;
  line-height: 2;
}
.advice {
  margin-bottom: 12px;
}
.advice-title {
  font-weight: 600;
  margin-bottom: 4px;
}
.advice p {
  margin: 0;
  font-size: 13px;
  color: #6b7263;
  line-height: 1.8;
}
.item-row {
  display: flex;
  justify-content: space-between;
  gap: 8px;
  padding: 8px 0;
  border-bottom: 1px dashed #eef1e5;
  font-size: 13px;
}
.item-row:last-child {
  border-bottom: none;
}
.i-name {
  flex: 1;
  display: flex;
  align-items: center;
}
.i-value {
  font-weight: 600;
  color: #404838;
}
.i-range {
  width: 150px;
  text-align: right;
  font-size: 11px;
  color: var(--text-sub);
}
</style>
