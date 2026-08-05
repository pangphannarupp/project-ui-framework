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
  
  // Find components that start with PP + baseName (case insensitive or something)
  // Or just check if the component name includes baseName
  const matchingComps = allComponents.filter(c => {
    // E.g., AccountReorder -> PPAccountReorderList
    // E.g., Dialog -> PPDialog or PPConfirm
    // E.g., CollapseAppbar -> PPCollapseAppbar
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
        // Exclude generic ones like --pp-primary, --pp-border unless they are the only ones
        variables.add(v);
      });
    }
  });
  
  // Filter out truly global ones to keep it specific, or keep them if it's the only thing.
  const globalVars = ['--pp-primary', '--pp-primary-variant', '--pp-primary-light', '--pp-surface', '--pp-background', '--pp-text-color', '--pp-border-color', '--pp-border-radius', '--pp-danger-color', '--pp-success-color', '--pp-warning-color', '--pp-background-alt'];
  
  let specificVars = [...variables].filter(v => !globalVars.includes(v)).sort();
  
  let cssVarContent = '';
  if (specificVars.length > 0) {
    cssVarContent = specificVars.map(v => `  ${v}: /* value */;`).join('\n');
  } else {
    cssVarContent = `  /* No specific CSS variables found for this component. */\n  /* It primarily uses global variables like --pp-primary or --pp-surface. */`;
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
    console.log(`Updated ${section} with vars from ${matchingComps.join(', ')}`);
  }
});
