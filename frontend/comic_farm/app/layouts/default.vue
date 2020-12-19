<template>
  <div id="main">
    <Header />
    <Sidebar />
    <Footer />
  </div>
</template>

<script>
import Header from "~/components/header/Header.vue";
import Footer from "~/components/footer/Footer.vue";
import Sidebar from "~/components/sidebar/Sidebar.vue";

export default {
  components: {
    Header,
    Footer,
    Sidebar,
  },
};
</script>
