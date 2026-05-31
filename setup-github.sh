#!/bin/bash
set -e

TOKEN="YOUR_GITHUB_TOKEN"
GITHUB_USER="nicolasmusa03-ops"
REPO_NAME="musastudiosco-website"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "→ Creating GitHub repository..."
RESPONSE=$(curl -s -X POST https://api.github.com/user/repos \
  -H "Authorization: token $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"Musa Studios portfolio website\",\"private\":false,\"auto_init\":false}")

REPO_URL=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('clone_url','ERROR: '+d.get('message','unknown')))" 2>/dev/null || echo "ERROR")

if [[ "$REPO_URL" == ERROR* ]]; then
  echo "❌ Failed to create repo: $REPO_URL"
  exit 1
fi

echo "✓ Repo created: https://github.com/$GITHUB_USER/$REPO_NAME"

echo "→ Configuring git..."
cd "$PROJECT_DIR"
git config user.name "Nicolas Musa"
git config user.email "nicolas.musa03@gmail.com"

echo "→ Committing files..."
git add -A
git commit -m "Initial commit"

echo "→ Pushing to GitHub..."
git remote add origin "https://$TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
git branch -M main
git push -u origin main

echo ""
echo "✅ Done! Repo live at: https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
echo "Next: set up Cloudflare Pages at https://dash.cloudflare.com"
echo "  1. Go to Workers & Pages → Create → Pages → Connect to Git"
echo "  2. Select the '$REPO_NAME' repo"
echo "  3. Build settings: leave blank (static site)"
echo "  4. Deploy — you'll get a *.pages.dev URL with auto-deploy on every push"
