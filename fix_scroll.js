const fs = require('fs');
const path = require('path');

const dir = 'web/src/views/web-portal';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue') && f !== 'WebPortalRoot.vue');

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let changed = false;

  // Wrap inside <ion-page> with <ion-content>
  if (content.includes('<ion-page>') && !content.includes('<ion-content>')) {
    content = content.replace(/<ion-page>([\s\S]*?)<\/ion-page>/g, '<ion-page>\n    <ion-content>$1</ion-content>\n  </ion-page>');
    changed = true;
  }

  // Add IonContent to the imports
  if (changed && !content.includes('IonContent')) {
    content = content.replace(/import\s+{([^}]*IonPage[^}]*)}\s+from\s+'@ionic\/vue'/g, (match, imports) => {
      // prevent adding it multiple times
      if (!imports.includes('IonContent')) {
        return `import { ${imports.trim()}, IonContent } from '@ionic/vue'`;
      }
      return match;
    });
  }

  if (changed) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${file}`);
  }
}
