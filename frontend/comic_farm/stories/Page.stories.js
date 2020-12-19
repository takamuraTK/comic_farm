import Page from './Page'

export default {
  title: 'Page',
  component: Page
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Page },
  template: `<Page />`
})

export const Default = Template.bind({})
Default.args = {}
