const fs = require('fs');
const path = require('path');

const dir = path.join(__dirname, 'web/src/views/guide-sections');
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue'));

const mapping = {
  'MonthPickerSection.vue': ['PPMonthPickerInput', 'monthModel'],
  'YearPickerSection.vue': ['PPYearPickerInput', 'yearModel'],
  'QuarterPickerSection.vue': ['PPQuarterPickerInput', 'quarterModel'],
  'TimePickerSection.vue': ['PPTimePickerInput', 'timeModel'],
  'DateRangeSection.vue': ['PPDateRangePickerInput', 'dateRangeModel'],
  'ColorPickerSection.vue': ['PPColorPickerInput', 'colorModel'],
};

for (const file of files) {
  if (!mapping[file]) continue;
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf-8');
  
  const [componentName, modelName] = mapping[file];

  // 1. Add import
  // Find the large import from 'ui-framework' and append the componentName
  content = content.replace(/(import \{[\s\S]*?)(\} from '(@phanna\/)?ui-framework';)/g, (match, p1, p2) => {
    if (p1.includes(componentName)) return match;
    return `${p1}, ${componentName} ${p2}`;
  });

  // 2. Add ref for model if not exists
  if (!content.includes(`const ${modelName} = ref`)) {
    content = content.replace(/(const show.* = ref\(false\);)/, `const ${modelName} = ref(null);\n$1`);
    // update the inner source code block as well
    content = content.replace(/(const show.* = ref\(false\);)/g, `const ${modelName} = ref(null);\n$1`);
  }

  // 3. Add variant to template
  const variantBlock = `
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;${componentName}&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <${componentName} v-model="${modelName}" />
          </div>
          <pre class="code-block"><code>&lt;${componentName} v-model="${modelName.replace('Model', '')}" /&gt;</code></pre>
        </div>
`;
  if (!content.includes(`<${componentName}`)) {
    content = content.replace(/<div class="variant-group">/, variantBlock + '\n        <div class="variant-group">');
  }

  fs.writeFileSync(filePath, content, 'utf-8');
  console.log(`Updated ${file}`);
}
