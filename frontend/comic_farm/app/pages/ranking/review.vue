<template>
  <div>
    <h2>review ranking</h2>
    <li v-for="book in books.data" :key="book.id">
      {{ book.title }}
      {{ book.point }}
      <img class="white--text align-end" height="300px" :src="book.image_url" />
    </li>
  </div>
</template>

<script>
export default {
  async asyncData({ app }) {
    const books = await app.$axios.$get("http://localhost/ranking/review");
    return {
      books
    };
  }
};
</script>
