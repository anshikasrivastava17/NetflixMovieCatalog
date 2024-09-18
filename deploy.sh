#!/bin/bash

# Variables
REPO_URL="https://github.com/yourusername/NetflixMovieCatalog.git"  # Replace with your GitHub repo URL
APP_DIR=~/app  # Directory where the app will be stored

# Clone the repository (or pull the latest changes if it already exists)
if [ ! -d "$APP_DIR/NetflixMovieCatalog" ]; then
  echo "Cloning repository..."
  git clone $REPO_URL $APP_DIR/NetflixMovieCatalog
else
  echo "Repository exists. Pulling latest changes..."
  cd $APP_DIR/NetflixMovieCatalog
  git pull origin main
fi

# Change to the app directory
cd $APP_DIR/NetflixMovieCatalog

# Create a Python virtual environment and activate it
if [ ! -d "venv" ]; then
  echo "Creating virtual environment..."
  python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

# Install required dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Stop any existing Flask app instance (optional, if using a process manager)
echo "Stopping any running Flask app..."
pkill -f "python app.py" || true  # If Flask is running, kill it; ignore error if not running

# Start the Flask app in the background
echo "Starting Flask app..."
nohup python app.py > flask.log 2>&1 &

echo "Deployment completed successfully!"
