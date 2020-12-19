import Header from './Header'

export default {
  title: 'Header',
  component: Header,
  argTypes: {
    logout: {
      action: 'logout'
    }
  }
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { Header },
  template: `
    <Header
      @logout="logout"
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
