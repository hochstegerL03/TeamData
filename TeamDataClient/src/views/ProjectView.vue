<template>
  <div class="container">
    <div class="rahmen container-fluid">
      <div>
        <p class="mb-1 pt-3" style="font-family: 'Syne Mono', monospace; font-size: 3rem">
          Welcome at TeamData!
        </p>
        <p style="font-family: 'Syne Mono', monospace; margin: 0">
          Here you will find all open Projects. Don't hesitate to play around to your heart's
          content!
        </p>
        <p style="font-family: 'Syne Mono', monospace">
          <i>We already got everything backed up!</i>
        </p>
        <ProjectCards name="Robert"></ProjectCards>
      </div>
    </div>
  </div>
</template>

<script setup>
import ProjectCards from '../components/ProjectCards.vue';
</script>
