const fs = require('fs');
const path = require('path');

const srcFile = path.join(__dirname, 'src/views/UsageGuide.vue');
const destDir = path.join(__dirname, 'src/views/guide-sections');

if (!fs.existsSync(destDir)) {
  fs.mkdirSync(destDir, { recursive: true });
}

const content = fs.readFileSync(srcFile, 'utf8');

// 1. Extract script setup block
const scriptMatch = content.match(/<script setup lang="ts">([\s\S]*?)<\/script>/);
const scriptContent = scriptMatch ? scriptMatch[1] : '';

// 2. Parse script statements (very basic parsing)
const statements = [];
const scriptLines = scriptContent.split('\n');
let currentStatement = '';
for (let i = 0; i < scriptLines.length; i++) {
  const line = scriptLines[i];
  if (line.trim() === '') continue;
  
  if (/^(const |let |function |import )/.test(line.trim())) {
    if (currentStatement) statements.push(currentStatement);
    currentStatement = line + '\n';
  } else {
    currentStatement += line + '\n';
  }
}
if (currentStatement) statements.push(currentStatement);

// 3. Extract the componentsMenu to generate component file names
const menuMatch = scriptContent.match(/const componentsMenu = (\[[\s\S]*?\]);/);
let menuItems = [];
if (menuMatch) {
  try {
    const ids = [...menuMatch[1].matchAll(/id:\s*'([^']+)'/g)].map(m => m[1]);
    menuItems = ids;
  } catch (e) {
    console.error(e);
  }
}

function toPascalCase(str) {
  return str.split('-').map(part => part.charAt(0).toUpperCase() + part.slice(1)).join('') + 'Section';
}

// 4. Extract sections
const sectionMap = {};

for (const id of menuItems) {
  const startTag = `<div class="guide-section" v-show="selectedComponentId === '${id}'">`;
  const startIndex = content.indexOf(startTag);
  if (startIndex === -1) {
    console.log(`Section ${id} not found.`);
    continue;
  }
  
  let nestCount = 0;
  let endIndex = startIndex;
  let foundEnd = false;
  
  const divRegex = /<\/?div[^>]*>/g;
  divRegex.lastIndex = startIndex;
  
  let match;
  while ((match = divRegex.exec(content)) !== null) {
    if (match[0].startsWith('<div')) nestCount++;
    else if (match[0].startsWith('</div')) nestCount--;
    
    if (nestCount === 0) {
      endIndex = divRegex.lastIndex;
      foundEnd = true;
      break;
    }
  }
  
  if (foundEnd) {
    const sectionHtml = content.slice(startIndex, endIndex);
    const componentName = toPascalCase(id);
    sectionMap[id] = componentName;
    
    // Clean up html (remove v-show)
    const cleanHtml = sectionHtml.replace(` v-show="selectedComponentId === '${id}'"`, '');
    
    const requiredStatements = [];
    const usedVariables = new Set();
    
    statements.forEach(stmt => {
      const declMatch = stmt.match(/^(?:const|let|function)\s+([a-zA-Z0-9_]+)/);
      if (declMatch) {
        const varName = declMatch[1];
        if (cleanHtml.includes(varName) || cleanHtml.includes(`@${varName}`) || cleanHtml.includes(`:${varName}`)) {
          requiredStatements.push(stmt);
          usedVariables.add(varName);
        }
      }
    });
    
    // special case for alertVal function which is used globally
    if (cleanHtml.includes('alertVal') && !usedVariables.has('alertVal')) {
      const alertValStmt = statements.find(s => s.includes('const alertVal'));
      if (alertValStmt) requiredStatements.push(alertValStmt);
    }
    
    statements.forEach(stmt => {
      if (stmt.trim().startsWith('import')) {
        const importMatch = stmt.match(/import\s+{([^}]+)}/);
        if (importMatch) {
          const imports = importMatch[1].split(',').map(s => s.trim());
          const usedImports = imports.filter(imp => cleanHtml.includes(imp) || [...usedVariables].some(v => stmt.includes(imp)));
          if (usedImports.length > 0) {
            const moduleMatch = stmt.match(/from\s+['"]([^'"]+)['"]/);
            if (moduleMatch) {
              requiredStatements.push(`import { ${usedImports.join(', ')} } from '${moduleMatch[1]}';\n`);
            }
          }
        }
      }
    });
    
    requiredStatements.unshift(`import { ref, computed } from 'vue';\n`);
    const finalScript = requiredStatements.join('\n');
    
    const fileContent = `<template>\n${cleanHtml}\n</template>\n\n<script setup lang="ts">\n${finalScript}</script>\n`;
    fs.writeFileSync(path.join(destDir, `${componentName}.vue`), fileContent);
    console.log(`Generated ${componentName}.vue`);
  }
}

// Generate an index.ts file to export all sections
let indexContent = '';
for (const [id, comp] of Object.entries(sectionMap)) {
  indexContent += `export { default as ${comp} } from './${comp}.vue';\n`;
}
fs.writeFileSync(path.join(destDir, 'index.ts'), indexContent);
console.log('Generated index.ts');

console.log(JSON.stringify(sectionMap, null, 2));
