# Rozgar Map Quiz

A complete MERN Stack Quiz Portal.

## Quick Deploy

See `DEPLOY.md` for complete step-by-step instructions.

## Your Credentials (Pre-configured in server/.env)

- MongoDB: Direct connection string (works in Pakistan)
- JWT Secret: Pre-generated

## Project Structure

```
rozgar-map-quiz/
├── client/          # React Frontend (Vite + Tailwind)
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── layouts/
│   │   ├── services/
│   │   ├── hooks/
│   │   └── context/
│   └── package.json
│
├── server/          # Node.js Backend (Express + MongoDB)
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── middlewares/
│   ├── utils/
│   ├── seeders/
│   ├── server.js
│   ├── setup-admin.js
│   ├── vercel.json
│   └── package.json
│
└── DEPLOY.md        # Deployment guide
```

## Features
- Student Quiz (no login required)
- Admin Panel (JWT protected)
- Category & Question CRUD
- Excel/JSON bulk import
- Results export (Excel/CSV)
- Dark mode
- Responsive design

## Brand
- Name: Rozgar Map Quiz
- Colors: Blue #1B4F9E, Red #E63946
- Footer: Made By Maghfoor Ahmad
