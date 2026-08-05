const fs = require('fs');
const path = require('path');

const sectionsDir = '/Users/pangphanna/personal/project-ui-framework/web/src/views/guide-sections/';
const componentsDir = '/Users/pangphanna/personal/project-ui-framework/web/ui-framework/src/components/';

const sections = fs.readdirSync(sectionsDir).filter(f => f.endsWith('Section.vue') && f !== 'ButtonSection.vue' && f !== 'InstallationSection.vue');

sections.forEach(section => {
  const sectionPath = path.join(sectionsDir, section);
  let content = fs.readFileSync(sectionPath, 'utf8');
  
  // Find all PP components used in the template or script
  const ppMatches = content.match(/PP[A-Za-z0-9]+/g);
  let variables = new Set();
  
  if (ppMatches) {
    const uniquePPs = [...new Set(ppMatches)];
    
    uniquePPs.forEach(pp => {
      // Find the component file
      const compPath = path.join(componentsDir, `${pp}.vue`);
      if (fs.existsSync(compPath)) {
        const compContent = fs.readFileSync(compPath, 'utf8');
        const varMatches = compContent.match(/--pp-[a-zA-Z0-9-]+/g);
        if (varMatches) {
          varMatches.forEach(v => variables.add(v));
        }
      }
    });
  }
  
  const varsArray = [...variables].sort();
  let cssVarContent = '';
  
  if (varsArray.length > 0) {
    cssVarContent = varsArray.map(v => `  ${v}: /* value */;`).join('\n');
  } else {
    cssVarContent = `  /* No specific CSS variables found for this component. */\n  /* It inherits global --pp- variables (e.g., --pp-primary). */`;
  }

  const newSnippet = `/* Override globally */
:root {
${cssVarContent}
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}`;

  // Replace the old generic text with the new one
  const regex = /\/\* Override globally \*\/[\s\S]*?\.my-custom-component \{\n  \/\* Add your custom styles \*\/\n\}/;
  if (regex.test(content)) {
    content = content.replace(regex, newSnippet);
    fs.writeFileSync(sectionPath, content, 'utf8');
    console.log(`Updated ${section} with specific CSS vars.`);
  }
});
