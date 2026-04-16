import React, { useState, useEffect } from 'react'
import './App.css'

interface Deck {
    id: string
    name: string
    class: string
    cardCount: number
}

function App() {
    const [decks, setDecks] = useState<Deck[]>([])
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const fetchDecks = async () => {
            try {
                const response = await fetch('/api/decks')
                const data = await response.json()
                setDecks(data.data || [])
            } catch (error) {
                console.error('Error fetching decks:', error)
            } finally {
                setLoading(false)
            }
        }

        fetchDecks()
    }, [])

    return (
        <div className="app">
            <header>
                <h1>🃏 Slay the Spire Deck Builder</h1>
                <p>Create and share your favorite decks</p>
            </header>

            <main>
                <section className="hero">
                    <h2>Welcome to the Deck Builder</h2>
                    <p>Build, share, and discuss your Slay the Spire decks with the community.</p>
                    <button className="btn-primary">+ Create New Deck</button>
                </section>

                <section className="decks-grid">
                    <h2>Popular Decks</h2>
                    {loading ? (
                        <p>Loading decks...</p>
                    ) : decks.length > 0 ? (
                        <div className="grid">
                            {decks.map((deck) => (
                                <div key={deck.id} className="deck-card">
                                    <h3>{deck.name}</h3>
                                    <p>Class: {deck.class}</p>
                                    <p>Cards: {deck.cardCount}</p>
                                    <button>View Deck</button>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p>No decks yet. Be the first to create one!</p>
                    )}
                </section>
            </main>
        </div>
    )
}

export default App
