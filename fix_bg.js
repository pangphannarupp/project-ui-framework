const fs = require('fs');
const path = require('path');

const dir = 'web/src/views/web-portal';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue') && f !== 'WebPortalRoot.vue');

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let changed = false;

  // check if ion-content style exists
  if (!content.includes('ion-content {') && !content.includes('--background: transparent')) {
    // Add ion-content style
    content = content.replace(/<style scoped>/, '<style scoped>\nion-content {\n  --background: transparent;\n}\n');
    changed = true;
  }

  // Also remove old ion-page background transparent if it's there
  if (content.includes('ion-page {\n  overflow-y: auto;\n  background: transparent;\n}')) {
      content = content.replace(/ion-page {\n  overflow-y: auto;\n  background: transparent;\n}/, '');
      changed = true;
  }

  if (changed) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${file}`);
  }
}
