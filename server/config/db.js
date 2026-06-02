const mongoose = require('mongoose')

const connectDB = async () => {
  try {
    console.log('====================')
    console.log('MongoDB Connect Start')
    console.log('URI Exists:', !!process.env.MONGODB_URI)
    console.log('====================')

    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      serverSelectionTimeoutMS: 10000
    })

    console.log('MongoDB Connected')
    console.log(conn.connection.host)

    return conn

  } catch (error) {
    console.error('====================')
    console.error('MONGODB CONNECTION ERROR')
    console.error(error.name)
    console.error(error.message)
    console.error(error)
    console.error('====================')

    throw error
  }
}

module.exports = connectDB