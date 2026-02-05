// controllers/authController.js
const authService = require('../services/authService')
const { signupSchema, loginSchema } = require('../validation/authValidation')

async function signup(req, res) {
  try {
    const { error, value } = signupSchema.validate(req.body)
    if (error) return res.status(400).json({ error: error.details[0].message })

    const user = await authService.signup(value)

    res.status(201).json(user)
  } catch (err) {
    console.error('Signup error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

async function login(req, res) {
  try {
    const { error, value } = loginSchema.validate(req.body)
    if (error) return res.status(400).json({ error: error.details[0].message })

    const result = await authService.login(value)

    res.json(result)
  } catch (err) {
    console.error('Login error', err)
    res.status(500).json({ error: 'Internal server error' })
  }
}

module.exports = {
  signup,
  login
}