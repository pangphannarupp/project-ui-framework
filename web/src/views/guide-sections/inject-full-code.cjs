const fs = require('fs');
const path = require('path');

const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue'));

const blockStart = '<!-- FULL_SOURCE_CODE_START -->';
const blockEnd = '<!-- FULL_SOURCE_CODE_END -->';

let updatedCount = 0;

files.forEach(file => {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Remove existing block if any to get the clean original content
  const regex = new RegExp(`${blockStart}[\\s\\S]*?${blockEnd}\\n?`, 'g');
  const cleanContent = content.replace(regex, '');
  
  // HTML escape the clean content for display
  const escapedContent = cleanContent
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
    
  // The block to inject
  const blockToInject = `${blockStart}
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;"><code>${escapedContent}</code></pre>
    </div>
${blockEnd}\n`;

  // Inject before the last closing </template>
  // We look for the last </template> in the file
  const lastTemplateIndex = cleanContent.lastIndexOf('</template>');
  
  if (lastTemplateIndex !== -1) {
    const newContent = cleanContent.slice(0, lastTemplateIndex) + blockToInject + cleanContent.slice(lastTemplateIndex);
    fs.writeFileSync(filePath, newContent, 'utf8');
    console.log(`Updated ${file}`);
    updatedCount++;
  } else {
    console.log(`Could not find </template> in ${file}`);
  }
});

console.log(`\nSuccessfully updated ${updatedCount} files.`);
