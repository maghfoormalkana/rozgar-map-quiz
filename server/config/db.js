const mongoose = require('mongoose')

const connectDB = async () => {
  try {
    console.log('Attempting MongoDB connection...')

    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      serverSelectionTimeoutMS: 30000
    })

    console.log('MongoDB Connected:', conn.connection.host)

    return conn
  } catch (error) {
    console.error('FULL MONGODB ERROR:')
    console.error(error)
    throw error
  }
}

module.exports = connectDB