import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'

dotenv.config()

const app = express()
const PORT = process.env.API_PORT || 3001

// Middleware
app.use(cors())
app.use(express.json())

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() })
})

// Decks endpoint (stub)
app.get('/api/decks', (req, res) => {
    res.json({
        success: true,
        data: [],
        message: 'Decks endpoint - database integration coming soon'
    })
})

// Cards endpoint (stub)
app.get('/api/cards', (req, res) => {
    res.json({
        success: true,
        data: [],
        message: 'Cards endpoint - database integration coming soon'
    })
})

// 404 handler
app.use((req, res) => {
    res.status(404).json({
        success: false,
        error: 'Not Found',
        path: req.path
    })
})

// Error handler
app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
    console.error('Error:', err)
    res.status(500).json({
        success: false,
        error: 'Internal Server Error',
        message: process.env.NODE_ENV === 'development' ? err.message : undefined
    })
})

app.listen(PORT, () => {
    console.log(`🚀 API running at http://localhost:${PORT}`)
    console.log(`📝 Health check: http://localhost:${PORT}/api/health`)
})
