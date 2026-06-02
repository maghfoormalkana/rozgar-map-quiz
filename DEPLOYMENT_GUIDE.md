# 🚀 Complete Deployment Guide: MongoDB Atlas → Vercel

## RozgarMap Quiz Portal - Step-by-Step

---

## STEP 1: MongoDB Atlas Setup

### 1.1 Create Account
1. Go to **https://www.mongodb.com/cloud/atlas**
2. Click **"Start Free"** and sign up (Google account recommended)
3. Choose **"Shared Cluster"** (FREE forever tier)

### 1.2 Create Cluster
1. Select **AWS** as cloud provider (closest to your region)
2. Choose region: **Mumbai (ap-south-1)** for Pakistan/India users
3. Cluster Tier: **M0 Sandbox (Shared RAM, 512 MB Storage)** - FREE
4. Cluster Name: `rozgar-cluster`
5. Click **"Create Cluster"** (takes 1-3 minutes)

### 1.3 Create Database User
1. Left sidebar → **Database Access**
2. Click **"Add New Database User"**
3. Authentication Method: **Password**
4. Username: `rozgaradmin`
5. Password: Generate a strong password (click auto-generate)
6. **SAVE THIS PASSWORD** - you cannot see it again!
7. Database User Privileges: **Read and write to any database**
8. Click **"Add User"**

### 1.4 Whitelist IP Address
1. Left sidebar → **Network Access**
2. Click **"Add IP Address"**
3. Click **"Allow Access from Anywhere"** (adds `0.0.0.0/0`)
   - ⚠️ This allows connections from any IP (required for Vercel serverless)
4. Click **"Confirm"**

### 1.5 Get Connection String
1. Left sidebar → **Database** → Click **"Connect"** on your cluster
2. Choose **"Drivers"**
3. Select **Node.js** and version **5.5 or later**
4. Copy the connection string:
```
mongodb+srv://rozgaradmin:<db_password>@rozgar-cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority
```
5. Replace `<db_password>` with your actual password
6. Add database name to the URL:
```
mongodb+srv://rozgaradmin:YOUR_PASSWORD@rozgar-cluster.xxxxx.mongodb.net/rozgar-quiz?retryWrites=true&w=majority
```

---

## STEP 2: Prepare Your Project

### 2.1 Extract the ZIP
```bash
# Windows
Right-click rozgar-quiz-portal.zip → Extract All

# Mac/Linux
unzip rozgar-quiz-portal.zip -d rozgar-quiz-portal
cd rozgar-quiz-portal
```

### 2.2 Update Environment Variables

**File: `server/.env`**
```env
PORT=5000
NODE_ENV=development

# Paste your MongoDB Atlas connection string here
MONGODB_URI=mongodb+srv://rozgaradmin:YOUR_PASSWORD@rozgar-cluster.xxxxx.mongodb.net/rozgar-quiz?retryWrites=true&w=majority

# Generate JWT Secret (run in terminal):
# node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
JWT_SECRET=your-64-character-hex-string-here
```

**File: `client/.env`**
```env
# For Vercel deployment (same domain)
VITE_API_URL=/api
```

### 2.3 Install Dependencies
```bash
# Install server dependencies
cd server
npm install

# Install client dependencies
cd ../client
npm install
```

### 2.4 Setup Admin Account
```bash
cd ../server
npm run setup
```
You will be prompted:
- Enter admin username: `admin`
- Enter admin password (min 8 chars): `yourpassword123`
- Confirm password: `yourpassword123`

✅ Admin account created in MongoDB Atlas!

### 2.5 Seed Sample Data (Optional)
```bash
npm run seed
```
This adds 7 categories and 15 sample questions.

---

## STEP 3: GitHub Repository

### 3.1 Create GitHub Repo
1. Go to **https://github.com/new**
2. Repository name: `rozgar-quiz`
3. Description: `RozgarMap Quiz Portal - MERN Stack`
4. Visibility: **Public** (or Private if you have Pro)
5. Click **"Create repository"**

### 3.2 Push Code to GitHub
```bash
# From project root (rozgar-quiz-portal/)
git init
git add .
git commit -m "Initial commit - RozgarMap Quiz Portal"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/rozgar-quiz.git
git push -u origin main
```

---

## STEP 4: Vercel Deployment

### 4.1 Create Vercel Account
1. Go to **https://vercel.com**
2. Sign up with **GitHub** (recommended)
3. Authorize Vercel to access your repositories

### 4.2 Import Project
1. Click **"Add New..."** → **"Project"**
2. Find and select your `rozgar-quiz` repository
3. Click **"Import"**

### 4.3 Configure Project
| Setting | Value |
|---------|-------|
| Framework Preset | **Other** |
| Root Directory | `.` (leave as is) |
| Build Command | `npm run build` |
| Output Directory | `client/dist` |
| Install Command | `npm install` |

### 4.4 Add Environment Variables
Click **"Environment Variables"** and add:

```
MONGODB_URI = mongodb+srv://rozgaradmin:YOUR_PASSWORD@rozgar-cluster.xxxxx.mongodb.net/rozgar-quiz?retryWrites=true&w=majority
JWT_SECRET = your-64-character-hex-string-here
NODE_ENV = production
```

⚠️ **Important**: Use the SAME values from your `server/.env` file!

### 4.5 Deploy
1. Click **"Deploy"**
2. Wait 2-3 minutes for build to complete
3. Vercel will provide a URL: `https://rozgar-quiz-xxx.vercel.app`

---

## STEP 5: Verify Deployment

### 5.1 Check Health Endpoint
Open in browser:
```
https://your-app.vercel.app/api/health
```
Should return:
```json
{"status":"OK","dbConnected":true,"timestamp":"..."}
```

### 5.2 Test Frontend
Visit your Vercel URL:
```
https://your-app.vercel.app
```
- Should show RozgarMap homepage
- Should be able to start a quiz

### 5.3 Test Admin Login
Visit:
```
https://your-app.vercel.app/admin/login
```
- Login with credentials you created in Step 2.4
- Should see Admin Dashboard

---

## STEP 6: Custom Domain (Optional)

### 6.1 Add Custom Domain on Vercel
1. Vercel Dashboard → Your Project → **Settings** → **Domains**
2. Enter your domain: `quiz.rozgarmap.com`
3. Follow Vercel's DNS instructions
4. Add CNAME record in your domain registrar pointing to `cname.vercel-dns.com`

### 6.2 Update CORS (if using custom domain)
In Vercel Environment Variables, add:
```
CLIENT_URL = https://quiz.rozgarmap.com
```

---

## TROUBLESHOOTING

### MongoDB Connection Failed
```
❌ querySrv ECONNREFUSED
```
**Fix:**
1. Check Network Access → `0.0.0.0/0` is added
2. Verify password in connection string (no special chars or URL-encode them)
3. Try direct connection string instead of SRV:
```
mongodb://rozgaradmin:PASSWORD@cluster0-shard-00-00.xxxxx.mongodb.net:27017,cluster0-shard-00-01.xxxxx.mongodb.net:27017,cluster0-shard-00-02.xxxxx.mongodb.net:27017/rozgar-quiz?ssl=true&replicaSet=atlas-xxxxx-shard-0&authSource=admin&retryWrites=true&w=majority
```

### Build Fails on Vercel
```
❌ Error: Cannot find module 'express'
```
**Fix:**
1. Check `server/package.json` has all dependencies
2. In Vercel Settings → General → Root Directory: leave as `.`
3. Build Command: `npm run build` (from root package.json)

### API Routes Return 404
```
❌ 404 on /api/health
```
**Fix:**
1. Check `vercel.json` is in project root
2. Ensure `api/index.js` exists and exports the Express app
3. Redeploy with "Use Existing Build Cache" unchecked

### Admin Login Not Working
```
❌ Invalid credentials
```
**Fix:**
1. Make sure `npm run setup` was run locally with correct MongoDB URI
2. Check admin exists in MongoDB Atlas → Browse Collections → rozgar-quiz → admins
3. If no admin, run setup again or use the first-time API endpoint

### CORS Errors in Browser
```
❌ Access-Control-Allow-Origin header missing
```
**Fix:**
1. In `server/server.js`, CORS is set to `origin: true` (allows all)
2. For production, change to your exact domain:
```javascript
app.use(cors({
  origin: 'https://your-app.vercel.app',
  credentials: true
}))
```

---

## IMPORTANT NOTES

### Vercel Free Tier Limits
| Feature | Limit |
|---------|-------|
| Serverless Function Duration | 10 seconds |
| Serverless Function Memory | 1024 MB |
| Bandwidth | 100 GB/month |
| Build Time | 6000 minutes/month |
| Concurrent Builds | 1 |

### MongoDB Atlas Free Tier
| Feature | Limit |
|---------|-------|
| Storage | 512 MB |
| RAM | Shared |
| Connections | 500 |
| Network Transfer | 10 GB/day in/out |

### Security Checklist
- [ ] Admin password is strong (8+ chars)
- [ ] JWT_SECRET is random 64-char string
- [ ] MongoDB password is strong
- [ ] IP whitelist is `0.0.0.0/0` (for Vercel)
- [ ] `setup-admin.js` deleted after setup
- [ ] `.env` file is in `.gitignore`
- [ ] No secrets committed to GitHub

---

## QUICK REFERENCE COMMANDS

```bash
# Local Development
cd server && npm run dev      # Backend: http://localhost:5000
cd client && npm run dev      # Frontend: http://localhost:3000

# Database
cd server && npm run setup    # Create admin account
cd server && npm run seed     # Add sample data

# Deployment
git add .
git commit -m "Update"
git push origin main          # Auto-deploys to Vercel

# Vercel CLI (optional)
npm i -g vercel
vercel login
vercel --prod
```

---

## SUPPORT

If you encounter issues:
1. Check Vercel Dashboard → **Deployments** → Click failed deploy → **Build Logs**
2. Check browser **Console** and **Network** tabs for API errors
3. Verify MongoDB Atlas → **Metrics** for connection issues
4. Contact: Maghfoor Ahmad (RozgarMap)

---

**🎉 RozgarMap Quiz Portal - Road to Success!**
