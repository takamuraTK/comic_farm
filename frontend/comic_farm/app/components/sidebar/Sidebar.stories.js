import Sidebar from './Sidebar'

export default {
  title: 'Sidebar',
  component: Sidebar,
  parameters: { actions: { argTypesRegex: '.*' } }
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Sidebar },
  template: `<Sidebar/>`
})

export const Default = Template.bind({})
Default.args = {}
