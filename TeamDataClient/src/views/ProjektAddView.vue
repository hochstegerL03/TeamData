<template>
  <div class="container">
    <p class="mb-1 pt-3" style="font-family: 'Syne Mono', monospace; font-size: 3rem">
      Welcome at TeamData!
    </p>
    <p style="font-family: 'Syne Mono', monospace; margin: 0">
      Here you will able to add new projects. Don't worry and just add something, we know that you
      want it!
    </p>
    <p style="font-family: 'Syne Mono', monospace" class="mb-3">
      <i>Ps: If it gets to messy, we will glady help you by bring some order back! </i>
    </p>
    <AddProjects></AddProjects>
  </div>
</template>
<script setup>
import AddProjects from '../components/AddProjects.vue';
</script>
