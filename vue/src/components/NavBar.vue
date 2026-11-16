<script setup>
import { useRouter } from 'vue-router'

defineProps({
  title: { type: String, default: '' },
  back: { type: Boolean, default: true },
})

const router = useRouter()
function goBack() {
  router.back()
}
</script>

<template>
  <div class="nav-bar">
    <div v-if="back" class="back" @click="goBack">
      <el-icon><ArrowLeft /></el-icon>
    </div>
    <div class="nav-title">{{ title }}</div>
    <slot name="right" />
  </div>
</template>
