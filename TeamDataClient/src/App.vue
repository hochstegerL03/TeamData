<script setup>
import { RouterLink, RouterView } from 'vue-router';
</script>

<template>
  <div class="container text-center">
    <nav class="my-4">
      <RouterLink to="/" class="nav-link">Projects </RouterLink>
      <RouterLink to="/about" class="nav-link"> Add Project </RouterLink>
    </nav>

    <div class="d-flex justify-content-center"><RouterView /></div>
  </div>
</template>

<style scoped>
a.nav-link {
  display: inline;
  color: gray;
  border-bottom: #00b4d8 3px solid;
}
a.nav-link:hover {
  color: #48cae4;
}
a.router-link-active {
  border-bottom: #0077b6 3px solid;
  color: black;
}

</style>
