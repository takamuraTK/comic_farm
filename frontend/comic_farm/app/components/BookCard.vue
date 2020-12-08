<template>
  <article class="overflow-hidden rounded-lg shadow-lg w-64 bg-white p-1">
    <div class="flex justify-center">
      <a href="#">
        <img
          alt="Placeholder"
          class="block w-60 h-64 object-cover"
          :src="book.image_url"
        />
      </a>
    </div>

    <header class="flex flex-col leading-tight p-2 md:p-4">
      <h1 class="text-lg">
        <a class="no-underline hover:underline text-black" href="#">
          {{ book.title }}
        </a>
      </h1>
      <p class="text-grey-darker text-sm">発売日 {{ book.salesDate }}</p>
    </header>

    <footer class="flex items-center justify-between leading-none p-2 md:p-4">
      <a
        class="flex items-center no-underline hover:underline text-black"
        href="#"
      >
        <img
          alt="Placeholder"
          class="block rounded-full"
          src="https://picsum.photos/32/32/?random"
        />
        <p class="ml-2 text-sm">
          {{ book.author }}
        </p>
      </a>
      <a class="no-underline text-grey-darker hover:text-red-dark" href="#">
        <span class="hidden">Like</span>
        <i class="fa fa-heart"></i>
      </a>
    </footer>
  </article>
</template>

<script>
export default {
  props: ["book"]
};
</script>
