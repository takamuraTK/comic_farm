import Footer from './Footer'

export default {
  title: 'Footer',
  component: Footer,
  parameters: { actions: { argTypesRegex: '.*' } }
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Footer },
  template: `<Footer/>`
})

export const Default = Template.bind({})
Default.args = {}
