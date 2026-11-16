<script setup>
import { onMounted, reactive, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  addOverallResult,
  archiveOrder,
  deleteOverallResult,
  getReportByOrder,
  saveReportGroup,
  updateOverallResult,
} from '@/assets/api'

const route = useRoute()
const router = useRouter()
const loading = ref(false)
const orderId = route.params.orderId
const order = ref(null)
const groups = ref([])
const conclusions = ref([])

const form = reactive({ title: '', content: '' })
const editingId = ref(null)

async function load() {
  loading.value = true
  try {
    const data = await getReportByOrder(orderId)
    order.value = data.order
    groups.value = data.groups
    conclusions.value = data.conclusions
  } finally {
    loading.value = false
  }
}

onMounted(load)

async function saveGroup(group) {
  await saveReportGroup(orderId, group.cirId, group.items)
  ElMessage.success(`${group.ciName}项已保存`)
}

function editConclusion(row) {
  editingId.value = row.orId
  form.title = row.title
  form.content = row.content
}

async function removeConclusion(row) {
  await ElMessageBox.confirm(`确定删除结论「${row.title}」吗？`, '提示', { type: 'warning' })
  await deleteOverallResult(row.orId)
  ElMessage.success('已删除')
  load()
}

async function submitConclusion() {
  if (!form.title.trim()) {
    ElMessage.warning('请输入总检结论项标题')
    return
  }
  if (editingId.value) {
    await updateOverallResult(editingId.value, form.title, form.content)
    ElMessage.success('已更新')
  } else {
    await addOverallResult(orderId, form.title, form.content)
    ElMessage.success('已添加')
  }
  clearForm()
  load()
}

function clearForm() {
  editingId.value = null
  form.title = ''
  form.content = ''
}

async function archive() {
  await ElMessageBox.confirm('归档后该体检报告将不可再编辑，确定归档？', '报告归档', { type: 'warning' })
  await archiveOrder(orderId)
  ElMessage.success('报告已归档')
  load()
}
</script>

<template>
  <div class="admin-main">
    <aside class="admin-aside">
      <div class="aside-title">预约客户信息</div>
      <div v-if="order" class="info">
        <div class="info-row"><span>预约编号</span><b>{{ order.orderId }}</b></div>
        <div class="info-row"><span>手机号码</span><b>{{ order.userId }}</b></div>
        <div class="info-row"><span>真实姓名</span><b>{{ order.realName }}</b></div>
        <div class="info-row"><span>性别</span><b>{{ order.sex === 1 ? '男' : '女' }}</b></div>
        <div class="info-row"><span>套餐类型</span><b>{{ order.setmealName }}</b></div>
        <div class="info-row"><span>体检日期</span><b>{{ order.orderDate }}</b></div>
      </div>
      <el-button type="primary" style="margin-top: 16px" @click="router.push('/admin/customers')">
        查询体检用户
      </el-button>
    </aside>

    <section class="admin-content" v-loading="loading">
      <div v-if="!order" class="admin-panel">未找到该预约信息</div>

      <template v-else>
        <div v-for="g in groups" :key="g.cirId" class="admin-panel group">
          <div class="group-title">{{ g.ciName }}</div>
          <div class="items">
            <div v-for="(it, i) in g.items" :key="i" class="item">
              <span class="i-name">
                <span v-if="it.isError" class="err">异</span>{{ it.name }}
              </span>
              <el-input v-if="it.type !== 4 && it.type !== 5" v-model="it.value" class="i-input" />
              <el-input v-else v-model="it.value" type="textarea" :rows="1" class="i-input" />
              <span class="i-unit">{{ it.unit }}</span>
              <span class="i-range">{{ it.normalValueString }}</span>
            </div>
          </div>
          <el-button type="primary" @click="saveGroup(g)">{{ g.ciName }}项保存</el-button>
        </div>

        <div class="admin-panel">
          <div class="group-head">
            <div class="group-title">总检结论</div>
            <el-button type="danger" @click="archive">体检套餐总检结果报告归档</el-button>
          </div>

          <el-table :data="conclusions" border style="width: 100%; margin-bottom: 16px">
            <el-table-column type="index" label="编号" width="70" />
            <el-table-column prop="title" label="总检结论项标题" width="220" />
            <el-table-column prop="content" label="总检结论项内容" />
            <el-table-column label="操作" width="140">
              <template #default="{ row }">
                <el-button link type="primary" @click="editConclusion(row)">更新</el-button>
                <el-button link type="danger" @click="removeConclusion(row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

          <div class="c-form">
            <div class="form-row">
              <label>总检结论项标题</label>
              <el-input v-model="form.title" placeholder="请输入标题" />
            </div>
            <div class="form-row">
              <label>总检结论项内容</label>
              <el-input v-model="form.content" type="textarea" :rows="3" placeholder="请输入内容" />
            </div>
            <div class="c-btns">
              <el-button type="primary" @click="submitConclusion">{{ editingId ? '保存修改' : '添加' }}</el-button>
              <el-button type="warning" @click="clearForm">清空</el-button>
            </div>
          </div>
        </div>
      </template>
    </section>
  </div>
</template>

<style scoped>
.info-row {
  display: flex;
  justify-content: space-between;
  font-size: 13px;
  padding: 7px 0;
  border-bottom: 1px solid #d3dac7;
}
.info-row span {
  color: #6b7263;
}
.group {
  margin-bottom: 16px;
}
.group-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 14px;
}
.group-title {
  font-weight: 700;
  font-size: 15px;
  margin-bottom: 12px;
  color: #4a5244;
}
.items {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px 30px;
  margin-bottom: 14px;
}
.item {
  display: flex;
  align-items: center;
  gap: 8px;
}
.i-name {
  width: 110px;
  text-align: right;
  font-size: 13px;
  color: #6b7263;
  flex-shrink: 0;
}
.i-input {
  max-width: 150px;
}
.i-unit {
  font-size: 12px;
  color: #8b927f;
  width: 60px;
  flex-shrink: 0;
}
.i-range {
  font-size: 12px;
  color: #8b927f;
  white-space: nowrap;
}
.err {
  display: inline-block;
  width: 16px;
  height: 16px;
  line-height: 16px;
  text-align: center;
  border-radius: 4px;
  background: #c97b6b;
  color: #fff;
  font-size: 10px;
  margin-right: 4px;
}
.c-form {
  max-width: 900px;
}
.c-btns {
  display: flex;
  gap: 12px;
  padding-left: 92px;
}
</style>
