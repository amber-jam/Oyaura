// tests/auth.test.js
const request = require('supertest')
const app = require('../index')
const db = require('../db')

beforeAll(async () => {
  await db.query('DELETE FROM users')
})

afterAll(async () => {
  await db.end()
})

describe('POST /auth/signup', () => {
  it('should create a new user', async () => {
    const res = await request(app)
      .post('/auth/signup')
      .send({
        username: 'Asia',
        email: 'asia@example.com',
        password: 'password123'
      })

    expect(res.statusCode).toBe(201)
    expect(res.body.user).toHaveProperty('user_id')
    expect(res.body.user.email).toBe('asia@example.com')
  })

  it('should reject duplicate email', async () => {
    const res = await request(app)
      .post('/auth/signup')
      .send({
        username: 'Asia2',
        email: 'asia@example.com',
        password: 'password123'
      })

    expect(res.statusCode).toBe(409)
  })
})
