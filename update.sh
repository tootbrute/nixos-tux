# add things to git
COMMIT_MSG="Update NixOS config."
echo "Commit message?"
read COMMIT_MSG
echo "OK!"

git add .
git commit -m "$COMMIT_MSG"
git push origin main
