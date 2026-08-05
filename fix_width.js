const fs = require('fs');
const path = require('path');

const dir = 'web/src/views/web-portal';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue'));

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  const original = content;
  
  content = content.replace(/padding:\s*40px;\s*\n\s*max-width:\s*1200px;\s*\n\s*margin:\s*0\s*auto;\s*\n\s*width:\s*100%;/g, 'padding: clamp(16px, 3vw, 40px);\n  width: 100%;');

  if (content !== original) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${file}`);
  }
}
