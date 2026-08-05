const fs = require('fs');
const path = require('path');

const sectionsDir = '/Users/pangphanna/personal/project-ui-framework/web/src/views/guide-sections/';
const componentsDir = '/Users/pangphanna/personal/project-ui-framework/web/ui-framework/src/components/';

const sections = fs.readdirSync(sectionsDir).filter(f => f.endsWith('Section.vue') && f !== 'ButtonSection.vue' && f !== 'InstallationSection.vue');
const allComponents = fs.readdirSync(componentsDir).filter(f => f.endsWith('.vue'));

sections.forEach(section => {
  const sectionPath = path.join(sectionsDir, section);
  let content = fs.readFileSync(sectionPath, 'utf8');
  
  const baseName = section.replace('Section.vue', '');
  
  const matchingComps = allComponents.filter(c => {
    const cName = c.replace('.vue', '').toLowerCase();
    const bName = baseName.toLowerCase();
    return cName.includes(bName) || bName.includes(cName.replace('pp', ''));
  });

  let variables = new Set();
  
  matchingComps.forEach(comp => {
    const compPath = path.join(componentsDir, comp);
    const compContent = fs.readFileSync(compPath, 'utf8');
    const varMatches = compContent.match(/--pp-[a-zA-Z0-9-]+/g);
    if (varMatches) {
      varMatches.forEach(v => {
        variables.add(v); // Keep ALL variables, even global ones, so the user sees exactly what affects this component.
      });
    }
  });
  
  let specificVars = [...variables].sort();
  
  let cssVarContent = '';
  if (specificVars.length > 0) {
    cssVarContent = specificVars.map(v => `  ${v}: /* value */;`).join('\n');
  } else {
    cssVarContent = `  /* This component does not use CSS variables directly. */\n  /* Use custom classes to override styles. */`;
  }

  const newSnippet = `/* Override globally */
:root {
${cssVarContent}
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}`;

  // Find the exact block we generated last time
  const regex = /\/\* Override globally \*\/[\s\S]*?\.my-custom-component \{\n  \/\* Add your custom styles \*\/\n\}/;
  if (regex.test(content)) {
    content = content.replace(regex, newSnippet);
    fs.writeFileSync(sectionPath, content, 'utf8');
    console.log(`Updated ${section} with vars from ${matchingComps.join(', ')}`);
  }
});
