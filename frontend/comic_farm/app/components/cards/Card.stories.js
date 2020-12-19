import Card from './Card'

export default {
  title: 'Card',
  component: Card,
  parameters: { actions: { argTypesRegex: '.*' } }
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Card },
  template: `<Card v-bind="$props"/>`
})

export const Default = Template.bind({})
Default.args = {
  book: {
    image_url: "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1246/9784065111246.jpg?_ex=350x350",
    title: "タイトル",
    salesDate: "2100年12月12日",
    author: "著者名"
  }
}
