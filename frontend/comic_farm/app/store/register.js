export const state = () => ({
  registerEmail: ""
})

export const getters = {
  registerEmail: (state) => state.registerEmail
}

export const mutations = {
  setRegisterEmail(state, email) {
    state.registerEmail = email
  }
}
