<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { queryCustomers } from '@/assets/api'

const router = useRouter()
const loading = ref(false)
const list = ref([])
const page = ref(1)
const pageSize = 10

const query = reactive({
  userId: '',
  realName: '',
  sex: '',
  type: '',
  orderDate: '',
  state: 1,
})

const total = computed(() => list.value.length)
const pageData = computed(() => list.value.slice((page.value - 1) * pageSize, page.value * pageSize))
const pages = computed(() => Math.max(1, Math.ceil(total.value / pageSize)))

async function search() {
  loading.value = true
  try {
    list.value = await queryCustomers(query)
    page.value = 1
  } finally {
    loading.value = false
  }
}

function reset() {
  Object.assign(query, { userId: '', realName: '', sex: '', type: '', orderDate: '', state: 1 })
  search()
}

function edit(row) {
  router.push(`/admin/report/${row.orderId}`)
}

onMounted(search)
</script>

<template>
  <div class="admin-main">
    <aside class="admin-aside">
      <div class="aside-title">体检客户查询</div>
      <div class="form-row"><label>手机号码</label><el-input v-model="query.userId" placeholder="手机号码" clearable /></div>
      <div class="form-row"><label>姓名</label><el-input v-model="query.realName" placeholder="姓名" clearable /></div>
      <div class="form-row">
        <label>性别</label>
        <el-radio-group v-model="query.sex">
          <el-radio :value="1">男</el-radio>
          <el-radio :value="0">女</el-radio>
        </el-radio-group>
      </div>
      <div class="form-row">
        <label>套餐类型</label>
        <el-select v-model="query.type" placeholder="套餐类型" clearable>
          <el-option label="男士套餐" :value="1" />
          <el-option label="女士套餐" :value="0" />
        </el-select>
      </div>
      <div class="form-row">
        <label>体检日期</label>
        <el-date-picker v-model="query.orderDate" type="date" value-format="YYYY-MM-DD" placeholder="体检日期" />
      </div>
      <div class="form-row">
        <label>是否归档</label>
        <el-radio-group v-model="query.state">
          <el-radio :value="1">未归档</el-radio>
          <el-radio :value="2">已归档</el-radio>
        </el-radio-group>
      </div>
      <div class="btns">
        <el-button type="primary" :icon="'Search'" @click="search">查询</el-button>
        <el-button type="warning" :icon="'Refresh'" @click="reset">重置</el-button>
      </div>
    </aside>

    <section class="admin-content">
      <div class="admin-panel">
        <el-table :data="pageData" v-loading="loading" border stripe style="width: 100%">
          <el-table-column prop="orderId" label="预约编号" min-width="110" />
          <el-table-column prop="userId" label="手机号码" min-width="120" />
          <el-table-column prop="realName" label="真实姓名" min-width="100" />
          <el-table-column label="性别" width="70">
            <template #default="{ row }">{{ row.sex === 1 ? '男' : '女' }}</template>
          </el-table-column>
          <el-table-column prop="setmealName" label="体检套餐类型" min-width="160" />
          <el-table-column prop="hospitalName" label="体检医院" min-width="200" />
          <el-table-column prop="orderDate" label="体检日期" min-width="120" />
          <el-table-column label="操作" width="140" fixed="right">
            <template #default="{ row }">
              <el-button link type="primary" @click="edit(row)">编辑体检报告</el-button>
            </template>
          </el-table-column>
        </el-table>

        <div class="pager">
          <span class="pg" @click="page = Math.max(1, page - 1)">‹</span>
          <span v-for="p in pages" :key="p" class="pg" :class="{ active: p === page }" @click="page = p">{{ p }}</span>
          <span class="pg" @click="page = Math.min(pages, page + 1)">›</span>
          <span>Total {{ total }}</span>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.btns {
  margin-top: 12px;
  display: flex;
  gap: 10px;
}
</style>
