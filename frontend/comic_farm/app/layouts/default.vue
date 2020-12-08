<template>
  <div id="main">
    <TheHeader />
    <TheSidebar />
    <TheFooter />
  </div>
</template>

<script>
import TheHeader from "~/components/TheHeader.vue";
import TheFooter from "~/components/TheFooter.vue";
import TheSidebar from "~/components/TheSidebar.vue";

export default {
  components: {
    TheHeader,
    TheFooter,
    TheSidebar
  }
};
</script>
