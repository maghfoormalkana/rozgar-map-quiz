const mongoose = require('mongoose')

let isConnected = false

const connectDB = async () => {
  if (isConnected) {
    console.log('Using existing MongoDB connection')
    return
  }

  try {
    console.log('MONGODB_URI exists:', !!process.env.MONGODB_URI)

    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      serverSelectionTimeoutMS: 30000
    })

    isConnected = true

    console.log(`MongoDB Connected: ${conn.connection.host}`)
    return conn
  } catch (error) {
    console.error('MongoDB Connection Error:')
    console.error(error)
    throw error
  }
}

module.exports = connectDB