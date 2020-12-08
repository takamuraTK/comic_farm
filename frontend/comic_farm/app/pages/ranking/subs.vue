<template>
  <div>
    <h2>subs ranking</h2>
    <li v-for="book in books.data" :key="book.id">
      {{ book.title }}
      {{ book.isbn }}
      <img class="white--text align-end" height="300px" :src="book.image_url" />
    </li>
    </li>
  </div>
</template>

<script>
export default {
  async asyncData({ app }) {
    const books = await app.$axios.$get("http://localhost/ranking/subs");
    return {
      books
    };
  }
};
</script>
