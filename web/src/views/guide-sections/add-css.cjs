const fs = require('fs');
const path = require('path');

const dir = '/Users/pangphanna/personal/project-ui-framework/web/src/views/guide-sections/';
const files = fs.readdirSync(dir);

const snippet = `
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block"><code>/* Override globally */
:root {
  /* Add component-specific CSS variables here */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
`;

files.forEach(file => {
  if (file.endsWith('Section.vue') && file !== 'ButtonSection.vue' && file !== 'InstallationSection.vue') {
    const filePath = path.join(dir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Check if it already has Customizing CSS
    if (!content.includes('Customizing CSS')) {
      // Find the last occurrence of </template>
      const templateEndIndex = content.lastIndexOf('</template>');
      if (templateEndIndex !== -1) {
        // We want to insert it before the closing </div> if there is one right before </template>
        // Let's just do a simple replacement: find the last `</div>\n</template>` or similar.
        // A safer way is to find `</template>` and insert before the last closing `</div>` that precedes it.
        
        const beforeTemplate = content.substring(0, templateEndIndex);
        const lastDivIndex = beforeTemplate.lastIndexOf('</div>');
        
        if (lastDivIndex !== -1) {
          const newContent = 
            content.substring(0, lastDivIndex) + 
            snippet + 
            content.substring(lastDivIndex);
          
          fs.writeFileSync(filePath, newContent, 'utf8');
          console.log(`Updated ${file}`);
        }
      }
    }
  }
});
