import Header from './Header'

export default {
  title: 'Header',
  component: Header,
  parameters: { actions: { argTypesRegex: '.*' } }
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Header },
  template: `
    <Header
      v-bind="$props"
    />
  `
})

export const LoggedIn = Template.bind({})
LoggedIn.args = {
  isLoggedIn: true
}

export const LoggedOut = Template.bind({})
LoggedOut.args = {
  isLoggedIn: false
}
