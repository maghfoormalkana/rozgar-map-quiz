# Deploy Rozgar Map Quiz to Vercel

## Your Credentials (Already in server/.env)

MongoDB: mongodb://maghfoormalkana:linkin4168b@ac-egf83m8-shard-00-00.rbqxtjy.mongodb.net:27017,ac-egf83m8-shard-00-01.rbqxtjy.mongodb.net:27017,ac-egf83m8-shard-00-02.rbqxtjy.mongodb.net:27017/rozgar-quiz?ssl=true&replicaSet=atlas-k7v8uh-shard-0&authSource=admin&appName=quiz-portal

JWT Secret: 5dbc323121224c8dbf06a4afbafcbf1c992e13f515f93c80be52210be36db0e8e0ea96906494ffa0cc6bd25c414550b6c59f236a07890eaf5cec52a475012919

---

## STEP 1: Push to GitHub

1. Open GitHub Desktop
2. File -> Add local repository -> Choose your `rozgar-map-quiz` folder
3. Commit message: "Initial commit"
4. Click "Publish repository"
5. Name it: `rozgar-map-quiz`

---

## STEP 2: Deploy Backend to Vercel

1. Go to https://vercel.com -> Sign up with GitHub
2. Click "Add New..." -> "Project"
3. Import `rozgar-map-quiz` repository
4. Configure:
   - Framework Preset: `Other`
   - Root Directory: `server`
   - Build Command: `npm install`
   - Output Directory: (leave empty)
5. Add Environment Variables:
   - MONGODB_URI: (your MongoDB string above)
   - JWT_SECRET: (your JWT secret above)
   - NODE_ENV: `production`
6. Click "Deploy"
7. Copy the deployed URL (e.g., `https://rozgar-map-quiz-server.vercel.app`)

---

## STEP 3: Create Admin Account

Open terminal and run:
```bash
curl -X POST https://YOUR-BACKEND-URL.vercel.app/api/admin/setup -H "Content-Type: application/json" -d "{"username":"admin","password":"YourPass123"}"
```
Replace `YOUR-BACKEND-URL` with your actual URL from Step 2.

---

## STEP 4: Deploy Frontend to Vercel

1. Go to https://vercel.com -> "Add New..." -> "Project"
2. Import the SAME `rozgar-map-quiz` repository
3. Configure:
   - Framework Preset: `Vite`
   - Root Directory: `client`
   - Build Command: `npm run build`
   - Output Directory: `dist`
4. Add Environment Variable:
   - VITE_API_URL: `https://YOUR-BACKEND-URL.vercel.app/api`
   (Replace with your backend URL from Step 2)
5. Click "Deploy"

---

## STEP 5: Connect CORS

1. Go to your Backend project on Vercel
2. Settings -> Environment Variables
3. Add: CLIENT_URL = `https://YOUR-FRONTEND-URL.vercel.app`
   (Replace with your frontend URL from Step 4)
4. Redeploy the backend

---

## Done!

- Frontend: https://YOUR-FRONTEND-URL.vercel.app
- Backend API: https://YOUR-BACKEND-URL.vercel.app/api
- Admin Login: https://YOUR-FRONTEND-URL.vercel.app/admin/login

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "Failed to fetch" | Check CLIENT_URL matches frontend URL exactly. Redeploy backend. |
| MongoDB timeout | Whitelist IP 0.0.0.0/0 in MongoDB Atlas Network Access. |
| Admin login fails | Run the curl command in Step 3 again. Check browser console (F12). |
| Build fails | Check Vercel logs. Make sure Root Directory is correct (server/client). |

---

## Updating Later

1. Make changes to local files
2. Open GitHub Desktop
3. See changes on the left
4. Enter commit message
5. Click "Commit to main" -> "Push origin"
6. Vercel auto-deploys!

---

Brand: Rozgar Map Quiz | Colors: Blue #1B4F9E, Red #E63946 | Footer: Made By Maghfoor Ahmad
