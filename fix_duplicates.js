const fs = require('fs');
const path = require('path');

const dir = path.join(__dirname, 'web/src/views/guide-sections');
const files = fs.readdirSync(dir).filter(f => f.endsWith('.vue'));

const mapping = {
  'MonthPickerSection.vue': 'monthModel',
  'YearPickerSection.vue': 'yearModel',
  'QuarterPickerSection.vue': 'quarterModel',
  'TimePickerSection.vue': 'timeModel',
  'DateRangeSection.vue': 'dateRangeModel',
  'ColorPickerSection.vue': 'colorModel',
};

for (const file of files) {
  if (!mapping[file]) continue;
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf-8');
  
  const modelName = mapping[file];
  const regex = new RegExp(`const ${modelName} = ref\\(null\\);\\n`, 'g');
  
  let matchCount = 0;
  content = content.replace(regex, (match) => {
    matchCount++;
    // Keep only the 1st match in the actual script, and 1st match in the FULL_SOURCE_CODE section.
    // Actually, a simpler way is just keep the first match after <script setup lang="ts">
    // But since there's a FULL_SOURCE_CODE section, there are two script blocks.
    // To be safe, we can just replace all occurrences of this line with empty string, 
    // and then insert it exactly once after "import { ref" in each script block.
    return '';
  });

  // Re-insert exactly once per script block
  content = content.replace(/(import \{ ref.*\} from 'vue';)/g, `$1\nconst ${modelName} = ref(null);`);
  
  fs.writeFileSync(filePath, content, 'utf-8');
  console.log(`Fixed ${file}`);
}
