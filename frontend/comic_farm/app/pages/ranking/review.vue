<template>
  <div class="h-full bg-gray-300">
    <h2 class="text-gray-900 text-base font-extrabold text-xl m-2">レビューランキング</h2>
    <div class="flex flex-wrap">
      <div v-for="book in books.data" :key="book.id" class="m-3">
        <BookCard :book="book" />
      </div>
    </div>
    </li>
  </div>
</template>

<script>
export default {
  async asyncData({ app }) {
    const books = await app.$axios.$get("/ranking/review");
    return {
      books
    };
  }
};
</script>
