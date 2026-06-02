#!/bin/bash

echo "RozgarMap Quiz Portal - Deployment Setup"
echo "==========================================="
echo ""

node_version=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$node_version" -lt 18 ]; then
    echo "Node.js 18+ required. Current: $(node -v)"
    exit 1
fi

echo "Node.js version: $(node -v)"
echo ""

echo "Installing server dependencies..."
cd server
npm install
if [ $? -ne 0 ]; then
    echo "Server npm install failed"
    exit 1
fi
echo "Server dependencies installed"
echo ""

echo "Installing client dependencies..."
cd ../client
npm install
if [ $? -ne 0 ]; then
    echo "Client npm install failed"
    exit 1
fi
echo "Client dependencies installed"
echo ""

echo "Building client for production..."
npm run build
if [ $? -ne 0 ]; then
    echo "Client build failed"
    exit 1
fi
echo "Client built successfully"
echo ""

cd ..

echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update server/.env with your MongoDB Atlas connection string"
echo "2. Run: cd server && npm run setup (to create admin account)"
echo "3. Run: cd server && npm run seed (to add sample data)"
echo "4. Start server: cd server && npm run dev"
echo "5. Start client: cd client && npm run dev"
