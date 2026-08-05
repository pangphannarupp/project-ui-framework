const fs = require('fs');
const path = require('path');

const dir = 'web/src/views/guide-sections';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue'));

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let changed = false;

  // Replace <pre ...> to include v-pre if it doesn't have it
  // This regex matches <pre ...> and adds v-pre before >
  content = content.replace(/<pre\b([^>]*?)>/g, (match, attrs) => {
    if (attrs.includes('v-pre')) {
      return match;
    }
    changed = true;
    return `<pre${attrs} v-pre>`;
  });

  if (changed) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${file}`);
  }
}
